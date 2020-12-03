//%attributes = {}
// PM: "zGetProjMethods" (new LV 17.07.20, 09:05:12)
// $0 - C_COLLECTION - $colProjMethods
// Get all Project-Method-Names
// -- A call example in javascript with callback function to assign result to jsVar myProjMethodNames:
//      $4d.zGetProjMethods(function(names){myProjMethodNames = names;});
// Last change: LV 16.09.20, 18:01:00

C_COLLECTION:C1488($colProjMethods;$0)
ARRAY TEXT:C222($arrProjMethodPaths;0)

// METHOD GET PATHS(Path project method;$arrProjMethodPaths;*)
// "METHOD GET PATHS" is little bit slower than "METHOD GET NAMES"
// but methodPath and methodName is identical for only method type projectMethod
// so using faster "METHOD GET NAMES", result is same for projectMethods
METHOD GET NAMES:C1166($arrProjMethodPaths;*)

// do not forget always all keys/names collections must sorted in descending order
// to try first detect "myTestFirst"
// and only when not("myTestFirst") than try detect "myTest"
SORT ARRAY:C229($arrProjMethodPaths;<)

$colProjMethods:=New collection:C1472  // "New collection" is needed for "ARRAY TO COLLECTION"
ARRAY TO COLLECTION:C1563($colProjMethods;$arrProjMethodPaths)  // "ARRAY TO COLLECTION" needs a existing collectionReference, with NULL did not works!

$0:=$colProjMethods

// - EOF -