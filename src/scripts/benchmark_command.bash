#!/bin/bash



## TODO / IN PROGRESS
function clean_results()
{
      grep ^real | cut -dm -f2 | sort | uniq -c | sort -n
}


repeats=20
output_file='benchmark_results.csv'
command_to_run='echo 1'


# exec $1

# print separating line
# printf "%$((${COLUMNS:-`tput cols`} - 10))s\n" ' ' | sed  's/ /-/g'


    # --------------------------------------------------------------------------
    # Benchmark loop
    # --------------------------------------------------------------------------
    echo 'Benchmarking ' $command_to_run '...';
    # Indicate the command we just run in the csv file
    echo '======' $command_to_run '======' >> $output_file;

    # Run the given command [repeats] times
    for (( i = 1; i <= $repeats ; i++ ))
    do
        # percentage completion
        p=$(( $i * 100 / $repeats))
        # indicator of progress
        l=$(seq -s "+" $i | sed 's/[0-9]//g')

        # runs time function for the called script, output in a comma seperated
        # format output file specified with -o command and -a specifies append
        /usr/bin/time -f "%E,%U,%S" -o ${output_file} -a ${command_to_run}

        # Clear the HDD cache (I hope?)
        # sync && echo 3 > /proc/sys/vm/drop_caches

        echo -ne ${l}' ('${p}'%) \r'
    done;

    echo -ne '\n'

    # Convenience seperator for file
    echo '--------------------------' >> $output_file


# for i in {0..500};
# do
#     # echo $i
#       time sh -c "echo $(( `sed -n 's/^MemFree:[\t ]\+\([0-9]\+\) kB/\1/Ip' /proc/meminfo`/1024 ))" &>/dev/null;
# done

# # print separating line
# # printf "%$((${COLUMNS:-`tput cols`} - 10))s\n" ' ' | sed  's/ /-/g'


# echo 2222
# exit $?
