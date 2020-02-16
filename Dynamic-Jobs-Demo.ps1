function checkJobState {
    $jobStatus = get-job * | Select-Object State | foreach ( { $_.State })
    if ("Running" -in $JobStatus) { $Global:Status = "Running" }else { $Global:Status = "Finished" }
}

#Items to run per job. Increase or decrease to distribute load over job tasks.
$items = 25
#Spawn 8 jobs (doing $items amount each)
$y = 0..7
$path = "\filepath"
$content = Import-CSV -Path $path

    foreach ($x in $y) {
        new-variable -Name ($x + "_jobvar") -value (start-job -Name ($x + "_job") -ScriptBlock {
                param ([string]$x) 
               
                if ($x -eq 0) { $a = 0; $b = $a + $items;write-host "true" }
                if ($x -eq ($z + 1)) { $a = $b + 1; $b = $a + $items}
                $z = $x
                
                #Distribute the workload
                $files = $files[$global:a..$global:b]

                #Each job now has a portion of the work to run.
                foreach ($file in $files) {
                #Do some action
                }  
            } -ArgumentList ($x)) 
    }
