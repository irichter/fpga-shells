# See LICENSE for license details.

# Set the variable for the directory that includes all scripts
set scriptdir [file dirname [info script]]

# Set up variables and Vivado objects
source [file join $scriptdir "prologue.tcl"]

# Initialize Vivado project files
source [file join $scriptdir "init.tcl"]

# Read the specified list of IP files
read_ip [glob -directory $ipdir [file join * {*.xci}]]

set_property top $top [current_fileset]

set_property strategy Performance_ExplorePostRoutePhysOpt [get_runs impl_1]
