function Get-TickerDetails
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)][string]$Name,
        [Parameter(Mandatory=$false)][DateTime]$Date = (Get-Date),
        [Parameter(Mandatory=$false)][switch]$OpenClose
    )
    <#
        .SYNOPSIS
            Display details of a stock market ticker on a specific date.
        .DESCRIPTION
            Display details of a stock market ticker on a specific date.
            Uses polygon.io to pull ticker information. See https://polygon.io/quote/tickers.
            You must set your polygon.io API Key as an environment variable "POLYGON_API_KEY.
        .PARAMETER Name
            Ticker name, for example "AAPL" for Apple.
        .PARAMETER Date
            Date for ticker details. US Date format MM/DD/YYYY.
        .PARAMETER OpenClose
            Include stock price and volume data.
        .EXAMPLE
            Get-TickerDetails -Name MSFT
        .EXAMPLE
            Get-TickerDetails -Name AAPL -Date 01/01/2005
        .EXAMPLE
            Get-TickerDetails -Name TSLA -Date 02/15/2023 -OpenClose
    #>  
    if ($Date.Year -lt 2004) { 
        return "polygon.io data only goes back to 2004, please adjust your date input."
    }
    if (($Date.DayOfWeek -eq "Saturday") -or ($Date.DayOfWeek -eq "Sunday")) { 
        return "There is no data for weekend days, make sure your date falls on a weekday."
    }
    if (!($env:POLYGON_API_KEY)) { 
        return "API Key was not provided. You must set your polygon.io API Key as an environment variable 'POLYGON_API_KEY'."
    }
    ## Variables
    $api_key = $env:POLYGON_API_KEY
    $date_str = $Date.toString("yyyy-MM-dd")
    ## REST API Calls with simple error handling
    try {
        $headers = @{
            "Authorization" = "Bearer $api_key"
        }
        $url = "https://api.polygon.io/v3/reference/tickers/" + $Name + "?date=" + $date_str
        $response = Invoke-WebRequest -Uri $url -Headers $headers
        $json_data = ($response.Content | ConvertFrom-Json).results
        if ($OpenClose) {
            try {
                $url = "https://api.polygon.io/v1/open-close/" + $Name + "/" + $date_str
                $response = Invoke-WebRequest -Uri $url -Headers $headers
                $open_close = ($response.Content | ConvertFrom-Json)
            }
            catch {
                $error_details = $_.ErrorDetails.Message | ConvertFrom-Json
                return $error_details
            }
        }
        return $json_data,$open_close
    }
    catch {
        $error_details = $_.ErrorDetails.Message | ConvertFrom-Json
        return $error_details
    }
}

Get-TickerDetails -Name MSFT -Date 2/21/23 -OpenClose