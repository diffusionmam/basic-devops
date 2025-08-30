# project 1 URL: https://roadmap.sh/projects/server-stats

## server-stats.sh

This script monitors and displays basic server statistics: CPU usage, memory usage, and disk usage. It defines several functions and variables to gather and print this information.

### Functions and Variables

#### 1. `get_cpu_usage()`
- **Purpose:** Retrieves and displays the current CPU usage percentage.
- **Variables:**
  - `CPU_USAGE`: Captures the CPU usage by running `top -bn1`, filtering the line with `Cpu(s)`, extracting the second field (user CPU usage) with `awk`, and removing the percent sign with `cut`.
- **Output:** Prints the CPU usage in the format: `CPU Usage: <value>%`.

#### 2. `get_memory_usage()`
- **Purpose:** Retrieves and displays the current memory usage in MB.
- **Variables:**
  - `MEMORY_USAGE`: Uses `free -m` to get memory stats in MB, then `awk` to format the total, used, and free memory.
- **Output:** Prints memory usage in the format: `Memory usage: Total: <total>MB, Used: <used>MB, Free: <free>MB`.

#### 3. `get_disk_usage()`
- **Purpose:** Retrieves and displays the disk usage for the root (`/`) filesystem.
- **Variables:**
  - `DISK_USAGE`: Uses `df -h /` to get disk usage in human-readable format, then `awk` to format the total, used, and free space.
- **Output:** Prints disk usage in the format: `Disk usage: Total: <total> (<used%> used), Used: <used>, Free: <free>`.

#### 4. `monitor_server()`
- **Purpose:** Calls the above three functions in sequence to display all server stats.

#### 5. Script Execution
- The last line, `monitor_server`, runs the monitoring function when the script is executed.

------------

# project 2 URL: https://roadmap.sh/projects/log-archive-tool

run the log archiver over any folder as `python logarch.py your-folder --email xyz@abc.com`


# project 3 URL: https://roadmap.sh/projects/nginx-log-analyser

there are two files, one using `awk`, the other using `grep` & `sed`, i just wrote the `awk` based file, but other one is here just for reference.

There are 3 important things while using `awk` command here, pipe `|`, `sort` and `head`. The pipe operation makes sure that the output of the query to the left is treated as input to the query at right, `sort -rn` sorts in reverse numeric order, because the default sort operation sorts according to lexical order (even in numericals). This is piped with `head -5` to get the top 5 values of the sort.
