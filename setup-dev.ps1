# Define SANDBOX_HOME
$SANDBOX_HOME = "C:\sandeep\sandbox"
$TEMP_DIR = "$SANDBOX_HOME\temp"

function DownloadZipAndExtract {
    param (
        [string]$URL,
        [string]$home_dir,
        [string]$package_dir
    )

    $full_path = Join-Path -Path $home_dir -ChildPath $package_dir

    # Check if the directory exists and delete it if it does
    # if (Test-Path -Path $full_path) {
    #     Remove-Item -Path $full_path -Recurse -Force
    # }

    # Check if Temporary directory exists and delete it if it does
    if (Test-Path -Path $TEMP_DIR) {
        Remove-Item -Path $TEMP_DIR -Recurse -Force
    }
    New-Item -ItemType Directory -Path $TEMP_DIR | Out-Null


    # Download the content from the URL
    $temp_zip = Join-Path -Path $TEMP_DIR -ChildPath "download.zip"
    Invoke-WebRequest -Uri $URL -OutFile $temp_zip


    # Check if the fullpath temp directory exists and delete it if it does
    $full_path_temp = Join-Path -Path $full_path -ChildPath "temp"
    if (Test-Path -Path $full_path_temp) {
        Remove-Item -Path $full_path_temp -Recurse -Force
    }

    # Extract the content to the specified directory
    Expand-Archive -Path $temp_zip -DestinationPath $full_path_temp

    # Check if $full_path_temp has more than one file or directory
    $items = Get-ChildItem -Path $full_path_temp
    $return_path = $full_path
    if ($items.Count -gt 1) {
        # Create a directory with the current date and time
        $dateTime = Get-Date -Format "yyyyMMdd_HHmmss"
        $newDir = Join-Path -Path $full_path -ChildPath $dateTime
        New-Item -ItemType Directory -Path $newDir | Out-Null

        # Copy all contents from $full_path_temp to the new directory
        $items | ForEach-Object {
            Copy-Item -Path $_.FullName -Destination $newDir -Recurse
        }
        $return_path = $newDir
    } else {
        $items | ForEach-Object {
            Copy-Item -Path $_.FullName -Destination $full_path -Recurse
            $return_path = "$full_path\$($_.Name)"
        }
    }

    # Clean up the temporary directory
    Remove-Item -Path $temp_dir -Recurse -Force
    Remove-Item -Path $full_path_temp -Recurse -Force

    return $return_path
}


function Set-EnvVariable {
    param (
        [string]$name,
        [string]$value,
        [string]$scope = "User"
    )
    [Environment]::SetEnvironmentVariable($name, $value, $scope)
}

function Check-PathEntry {
    param (
        [string]$entry,
        [string]$suffix
    )

    # Retrieve the current value of the PATH environment variable
    $path = [System.Environment]::GetEnvironmentVariable("PATH", "User")

    # Split the PATH variable into individual paths
    $pathEntries = $path -split ";"

    $entryValue = "%$entry%"

    # Check if the given entry exists in the list of paths
    if ($pathEntries -contains "$entryValue$suffix") {
        return $true
    } else {
        return $false
    }
}

function Add-PathEntryIfNotExists {
    param (
        [string]$entry,
        [string]$suffix = ""
    )

    if (-not (Check-PathEntry -entry $entry -suffix $suffix)) {
        # Retrieve the current value of the PATH environment variable
        $path = [System.Environment]::GetEnvironmentVariable("PATH", "User")

        # Add the new entry to the PATH
        $newPath = "$path;%$entry%$suffix"
        [System.Environment]::SetEnvironmentVariable("PATH", $newPath, "User")

        Write-Output "The entry '%$entry%$suffix' has been added to the PATH environment variable."
    }
}

function Install-Zip-Package-Locally {
    param (
        [string]$envVarName,
        [string]$package_dir,
        [string]$URL
    )
    $pacakge_path = DownloadZipAndExtract -URL $URL -home_dir $SANDBOX_HOME -package_dir $package_dir
    Set-EnvVariable -name $envVarName -value $pacakge_path
    Write-Output "The package has been installed at $pacakge_path"
}


# Chocolatey based installation
Write-Output "Tools Installation started"
# choco install 7zip.install -y
# choco install insomnia-rest-api-client -y
# choco install lens -y
# choco install notepadplusplus -y
# choco install postman -y
# choco install putty -y

Write-Output "AWS components installation started"
# choco install awscli -y

Write-Output "Docker components installation started"
# choco install docker-desktop -y

Write-Output "Repositories installation started"
# choco install git.install -y
# choco install gh -y

Write-Output "Azure tools installation started"
# choco install azure-cli -y

Write-Output "Python installation started"
# choco install python3 --pre  -y

Write-Output "Node JS installation started"
# choco install nodejs.install -y

Write-Output "IDEs installation started"
# choco install intellijidea-ultimate -y
# choco install eclipse -y
# choco install vscode -y

Write-Output "DB tools installation started"
# choco install mongodb-compass -y
# choco install oracle-sql-developer -y
# choco install postgresql -y

Write-Output "Zip Based packages installation"
# Install-Zip-Package-Locally -envVarName "_M2_HOME_3.9.9" -package_dir "maven" -URL "https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip"
# Install-Zip-Package-Locally -envVarName "_JMETER_HOME_5.6.3" -package_dir "jmeter" -URL "https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.6.3.zip"
# Install-Zip-Package-Locally -envVarName "_GRADLE_HOME_8.10.2" -package_dir "gradle" -URL "https://services.gradle.org/distributions/gradle-8.10.2-bin.zip"
# Install-Zip-Package-Locally -envVarName "_GRAALVM_HOME_21" -package_dir "graalvm" -URL "https://download.oracle.com/graalvm/21/latest/graalvm-jdk-21_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_8" -package_dir "java" -URL "https://download.java.net/openjdk/jdk8u44/ri/openjdk-8u44-windows-i586.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_9" -package_dir "java" -URL "https://download.java.net/openjdk/jdk9/ri/jdk-9+181_windows-x64_ri.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_10" -package_dir "java" -URL "https://download.java.net/openjdk/jdk10/ri/jdk-10+44_windows-x64_bin_ri.tar.gz"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_11" -package_dir "java" -URL "https://download.java.net/openjdk/jdk11.0.0.2/ri/openjdk-11.0.0.2_windows-x64.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_12" -package_dir "java" -URL "https://download.java.net/openjdk/jdk12/ri/openjdk-12+32_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_13" -package_dir "java" -URL "https://download.java.net/openjdk/jdk13/ri/openjdk-13+33_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_14" -package_dir "java" -URL "https://download.java.net/openjdk/jdk14/ri/openjdk-14+36_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_15" -package_dir "java" -URL "https://download.java.net/openjdk/jdk15/ri/openjdk-15+36_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_16" -package_dir "java" -URL "https://download.java.net/openjdk/jdk16/ri/openjdk-16+36_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_17" -package_dir "java" -URL "https://download.java.net/openjdk/jdk17.0.0.1/ri/openjdk-17.0.0.1+2_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_18" -package_dir "java" -URL "https://download.java.net/openjdk/jdk18/ri/openjdk-18+36_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_19" -package_dir "java" -URL "https://download.java.net/openjdk/jdk19/ri/openjdk-19+36_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_20" -package_dir "java" -URL "https://download.java.net/openjdk/jdk20/ri/openjdk-20+36_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_21" -package_dir "java" -URL "https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_22" -package_dir "java" -URL "https://download.java.net/openjdk/jdk22/ri/openjdk-22+36_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_JAVA_HOME_23" -package_dir "java" -URL "https://download.oracle.com/java/23/latest/jdk-23_windows-x64_bin.zip"
# Install-Zip-Package-Locally -envVarName "_VISUAL_VM_2.1.10" -package_dir "visualvm" -URL "https://github.com/oracle/visualvm/releases/download/2.1.10/visualvm_2110.zip"

Write-Output "Fixed Environment Variables"
# Set-EnvVariable "MISC_HOME" "$SANDBOX_HOME\misc"
# Set-EnvVariable "SANDBOX_HOME" "$SANDBOX_HOME"
# Set-EnvVariable "M2_HOME" "%_M2_HOME_3.9.9%"
# Set-EnvVariable "JMETER_HOME" "%_JMETER_HOME_5.6.3%"
# Set-EnvVariable "GRADLE_HOME" "%_GRADLE_HOME_8.10.2%"
# Set-EnvVariable "GRAALVM_HOME" "%_GRAALVM_HOME_21%"
# Set-EnvVariable "JAVA_HOME" "%_JAVA_HOME_17%"

Write-Output "Add Path Entries"
# Add-PathEntryIfNotExists "M2_HOME" "\bin"
# Add-PathEntryIfNotExists "GRADLE_HOME" "\bin"
# Add-PathEntryIfNotExists "JAVA_HOME" "\bin"
# Add-PathEntryIfNotExists "JMETER_HOME" "\bin"
# Add-PathEntryIfNotExists "MISC_HOME"
