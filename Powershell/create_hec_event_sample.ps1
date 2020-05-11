#original code located at following url
#https://answers.splunk.com/answers/373010/powershell-sample-for-http-event-collector.html

$response = ""
 $formatteddate = "{0:MM/dd/yyyy hh:mm:sstt zzz}" -f (Get-Date)
 $arraySeverity = 'INFO','WARN','ERROR'
 $severity = $arraySeverity[(Get-Random -Maximum ([array]$arraySeverity).count)]
 
 $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
 #need to setup HEC on an Indexer or HF and provide token
 $headers.Add("Authorization", 'Splunk xxxxx-xxx-xxxx-xxxx-xxxxxxxxxxxx')
 
 $body = '{
         "host":"' + $env:computername + '",
         "sourcetype":"testevents",
         "source":"Geoff''s PowerShell Script",
         "event":{
             "message":"Something Happened on host ' + $env:computername + '",
             "severity":"' + $severity + '",
             "user": "'+ $env:username + '",
             "date":"' + $formatteddate + '"
             }
         }'
 #provide ip or DNS name of HEC configured host
 $splunkserver = "http://xxx.xxx.xxx.xxx:8088/services/collector"
 $response = Invoke-RestMethod -Uri $splunkserver -Method Post -Headers $headers -Body $body
 "Code:'" + $response.code + "' text:'"+ $response.text + "'" 
