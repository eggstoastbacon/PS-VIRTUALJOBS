function checkJobState {
    $jobStatus = get-job * | Select-Object State | foreach ( { $_.State })
    if ("Running" -in $JobStatus) { $Global:Status = "Running" }else { $Global:Status = "Done" }
}

#Your content
$path = "filepath"
$files = 1..134
#Number of seperate jobs to spawn
$jobs = 5

$y = 0..($jobs - 1)
#divide the jobs up equally
$items = [math]::Round($files.count / $y.count)
if (($files.count / $y.count) -like "*.*") { $items = $items + 1 }


foreach ($x in $y) {
    start-job -Name ([string]$x + "_jobvar") -ScriptBlock {
        param ([string]$x, [int]$items, $files) 
                                
        if ($x -eq 0) { $a = 0 } else { $a = (([int]$items * $x) + 1) }               
        $b = (([int]$items * $x) + [int]$items)
                              
        #Distribute the workload
        $xfiles = $files[[int]$a..[int]$b] 

        #Each job now has a portion of the work to run.
        foreach ($xfile in $xfiles) {
            $xfile | out-file c:\temp\results_$x.txt -append
        }  
    } -ArgumentList ($x, $items, $files)
}

checkJobState
while ($Global:Status -notlike "Done") {
    start-sleep 3
    checkJobState
}
remove-job *
write-host "All jobs are done." -ForegroundColor Cyan
