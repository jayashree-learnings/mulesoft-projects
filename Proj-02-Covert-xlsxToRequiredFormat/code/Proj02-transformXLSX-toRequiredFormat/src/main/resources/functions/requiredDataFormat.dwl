fun myConcat(a:String, b:String) = a ++ b

fun createRequiredDataFormat(dataFormatQueryParam,dataFormatHeader) = 
  do {
	var dataFormat_required = 
	  if (not (isEmpty(dataFormatQueryParam)))
		 dataFormatQueryParam
	  else if (not isEmpty(dataFormatHeader)) 
		  splitBy(dataFormatHeader,"/")[1]
	  else "json"
---
dataFormat_required
}