import * as JValue from "JContainers/JValue"
import * as MiscUtil from "PapyrusUtil/MiscUtil"

let deserializationFileNextIndex = 0
let deserializationFileMaxCount = 100
let deserializationFilePath = "Data/JObjectToJson/"

export function setJsonDeserializationFileMaxCount(maxCount: number) {
    deserializationFileMaxCount = maxCount
}

export function setJsonDeserializationFilePath(folder: string) {
    deserializationFilePath = folder
}

export default function jObjectToJson(objectReferenceId: number): any {
    const tempFileName = `${deserializationFilePath}/temp_${deserializationFileNextIndex}.json`
    deserializationFileNextIndex++
    if (deserializationFileNextIndex > deserializationFileMaxCount)1
        deserializationFileMaxCount = 0
    JValue.writeToFile(objectReferenceId, tempFileName)
    const jsonString = MiscUtil.ReadFromFile(tempFileName)
    return JSON.parse(jsonString)
}
