scriptName JObjectToJson

string function ToJson(int jcontainersObjectReference, string tempFile = "", int tempFileMax = 100, string tempFileFolder = "Data/JObjectToJson/Temp0", string tempFilePrefix = "temp_", string tempFileSuffix = ".json") global
    if ! jcontainersObjectReference
        return ""
    endIf

    __lock()
    if ! tempFile
        int nextTempFileIndex = JDB.solveInt(".jObjectToJson.nextTempFileIndex")
        if nextTempFileIndex
            JDB.solveIntSetter(".jObjectToJson.nextTempFileIndex", nextTempFileIndex + 1)
        else
            nextTempFileIndex = 1
            JDB.solveIntSetter(".jObjectToJson.nextTempFileIndex", nextTempFileIndex, createMissingKeys = true)
        endIf
        tempFile = tempFileFolder + "/" + tempFilePrefix + nextTempFileIndex + tempFileSuffix
    endIf
    JValue.writeToFile(jcontainersObjectReference, tempFile)
    string json = MiscUtil.ReadFromFile(tempFile)
    __unlock()

    return json
endFunction

function __lock(float lockValue = 0.0, float waitInterval = 0.05) global
    if ! lockValue
         lockValue = Utility.RandomFloat(1, 1000000)
    endIf
    while JDB.solveFlt(".jObjectToJson.lock")
        Utility.WaitMenuMode(waitInterval)
    endWhile
    JDB.solveFltSetter(".jObjectToJson.lock", lockValue, createMissingKeys = true)
    if JDB.solveFlt(".jObjectToJson.lock") == lockValue
        if JDB.solveFlt(".jObjectToJson.lock") == lockValue
            return ; The lock is ours!
        else
            __lock(lockValue)
        endIf
    else
        __lock(lockValue)
    endIf
endFunction

function __unlock() global
    JDB.solveFltSetter(".jObjectToJson.lock", 0, createMissingKeys = true)
endFunction
