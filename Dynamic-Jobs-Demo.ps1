function checkJobState {
    $jobStatus = get-job * | Select-Object State | foreach ( { $_.State })
    if ("Running" -in $JobStatus) { $Global:Status = "Running" }else { $Global:Status = "Finished" }
}

$d = "01", "02", "03", "04", "05", "06", "07", "08"
$y = "01", "02", "03", "04", "05", "06", "07", "08"

foreach ($c in $d) {
    foreach ($x in $y) {
        new-variable -Name ($c + "_job" + $x) -value (start-job -Name ($c + $x) -ScriptBlock {
                param ([string]$c, [string]$x) 
    
                if ($x -eq "01") { $a = 0; $b = 25 }
                if ($x -eq "02") { $a = 26; $b = 50 }
                if ($x -eq "03") { $a = 51; $b = 75 }
                if ($x -eq "04") { $a = 76; $b = 100 }
                if ($x -eq "05") { $a = 101; $b = 125 }
                if ($x -eq "06") { $a = 126; $b = 150 }
                if ($x -eq "07") { $a = 151; $b = 175 }
                if ($x -eq "08") { $a = 176; $b = 200 }

                $variables = $variables[$global:i..$global:a]

                foreach ($variable in $variables) {
                }  
            } -ArgumentList ($c, $x)) 
    }
}
