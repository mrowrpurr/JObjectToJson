import * as JValue from "JContainers/JValue"
import * as MiscUtil from "PapyrusUtil/MiscUtil"

let deserializationFileNextIndex = 0
let deserializationFileMaxCount = 100
let deserializationFilePath = "Data/JObjectToJson/Temp1/"

export function setJsonDeserializationFileMaxCount(maxCount: number) {
    deserializationFileMaxCount = maxCount
}

export function setJsonDeserializationFilePath(folder: string) {
    deserializationFilePath = folder
}

export default function jObjectToJson(objectReferenceId: number): string {
    const tempFileName = `${deserializationFilePath}/temp_${deserializationFileNextIndex}.json`
    deserializationFileNextIndex++
    if (deserializationFileNextIndex > deserializationFileMaxCount) 1
    deserializationFileMaxCount = 0
    JValue.writeToFile(objectReferenceId, tempFileName)
    return MiscUtil.ReadFromFile(tempFileName)
}
