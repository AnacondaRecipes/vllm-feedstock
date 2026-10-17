# A tool to monitor the system memory for the duration of a running process.
# Intended to track memory usage of builds to optimize the number of parallel
# threads used for the build. After the application is done running, the
# script will print out some statistics and exit.

import psutil
import sys
import argparse
import asyncio
import time
import datetime
import yaml
import matplotlib
import matplotlib.pyplot
import pandas

def get_resource_info():
    #datetime.now()
    timestamp = datetime.datetime.now()
    meminfo = psutil.virtual_memory()
    resource_info = {
        "overall_cpu_percent": psutil.cpu_percent(),
        "per_cpu_percent": psutil.cpu_percent(percpu=True),
        "system_memory_percent": meminfo.percent,
        "system_memory_info": meminfo._asdict(),
        }
    return timestamp, resource_info

async def poll_resources(output_file="resource_usage.yaml", interval=5):
    results = {}
    
    with open(output_file, "w") as f:
        try:
            timestamp, current_resources = get_resource_info()
            start_time = timestamp
            results[timestamp] = current_resources
            yaml_str = yaml.dump({timestamp: current_resources})
            #print(yaml_str)
            f.write(yaml_str)

            while True:
                await asyncio.sleep(interval)

                timestamp, current_resources = get_resource_info()
                results[timestamp] = current_resources
                yaml_str = yaml.dump({timestamp: current_resources})
                #print(yaml_str)
                f.write(yaml_str)

        except asyncio.CancelledError:
            pass
        finally:
            timestamp, current_resources = get_resource_info()
            end_time = timestamp
            results[timestamp] = current_resources
            yaml_str = yaml.dump({timestamp: current_resources})
            #print(yaml_str)
            f.write(yaml_str)
    return results, start_time, end_time

async def amain(command_list, filename=None, interval=None):
    if filename is None:
        filename = "resource_usage.yaml"
    if interval is None:
        interval = 5
    print(f"Running command: {' '.join(command_list)}")
    print(f"Running command: {command_list}")
    returncode = 1
    try:
        proc = await asyncio.create_subprocess_exec(command_list[0], *command_list[1:] )
        proc_task = asyncio.create_task(proc.communicate(), name="Watched Process")
        resource_poll_task = asyncio.create_task(poll_resources(filename, interval=interval), name="Resource Polling")

        done = False

        while not done:

            completed, pending = await asyncio.wait([proc_task, resource_poll_task], return_when=asyncio.FIRST_COMPLETED)
            for task in completed:
                if task.get_name() == "Watched Process":
                    print(f"Finished running {command_list[0]}")
                    #print(f"result: {task.result()}")
                    print(f"proc returncode: {proc.returncode}")
                    returncode = proc.returncode

                    done = True
                    print(f"Process completed!")
    except asyncio.CancelledError:
        proc.terminate()
    finally:
        resource_poll_task.cancel()
        await resource_poll_task
        resource_usage, start, end = resource_poll_task.result()
        elapsed_time = end - start
        
        print(f"Total Elapsed time: {elapsed_time}")
        meminfo = {k-start:v["system_memory_info"] for k,v in resource_usage.items()}
        #print(f"Memory Info: {meminfo}")P
        df = pandas.DataFrame.from_dict(meminfo, orient="index")
        #print(f"Pandas DataFrame:\n{df}")
        plot = (df[['used']]/(1024**3)).plot()
        #plot.savefig()
        matplotlib.pyplot.savefig(filename + ".png")
        #matplotlib.pyplot.show()
    exit(returncode)
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--interval", type=float, action="store")
    parser.add_argument("--filename", action="store")
    parser.add_argument('command', nargs='+')
    parser.add_argument('--', dest="command")
    args = parser.parse_args(sys.argv[1:])

    with asyncio.Runner() as runner:
        runner.run(amain(args.command, filename=args.filename, interval=args.interval))