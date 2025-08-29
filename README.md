# basic-devops

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






project URL: https://roadmap.sh/projects/server-stats