// ignore_for_file: prefer_initializing_formals

class WasteResponse{
  int wasteID;
  int xPos;
  int yPos;
  int size;
  int wasteType;
  bool? isDeleted;
  DateTime? dateModified;

  WasteResponse({required int wasteID, required int xPos, required int yPos, required int size, required int wasteType, required bool isDeleted, required DateTime dateModified})
      : 
          wasteID = wasteID,
          xPos = xPos,
          yPos = yPos,
          size = size,
          wasteType = wasteType,
          isDeleted = isDeleted,
          dateModified = dateModified;
}