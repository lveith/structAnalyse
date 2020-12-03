<!-- PM: "sisCoverStringsWholeContent"<< $0 - C_TEXT - Result text whith covered content inner doubleQuoteStrings>> $1 - C_TEXT - srcTxt (any 4D srcCodeText)Cover Strings in doubleQuotes (whole content inner strings) -->
#### `sisCoverStringsWholeContent(srcCodeTxt4D) -> resultText`
---
## Description
Covers whole content inner doubleQuotesStrings
<table class="parTab">
  <thead>
    <tr style="color: white; background-color: cadetblue;">
      <td style="text-align: center;">Parameter</td>
      <td>Name</td>
      <td style="text-align: center;">Type</td>
      <td>Description</td>
    </tr>
  </thead>
  <tbody>
    <tr style="color: #555; background-color: white;">
      <td style="text-align: center; font-weight: bold;">$0</td>
      <td>resultText</td>
      <td style="text-align: center;">C_TEXT</td>
      <td>Result text whith covered content inner doubleQuoteStrings</td>
    </tr>
    <tr style="color: #555; background-color: white;">
      <td  style="text-align: center; font-weight: bold;">$1</td>
      <td>srcText</td>
      <td style="text-align: center;">C_TEXT</td>
      <td>Any 4D source code text</td>
    </tr>
  </tbody>
</table>

## Example
```4d
sisCoverStringsWholeContent("var:=\"a23456\"+Timestamp")
// -> "var:=\"⬝⬝⬝⬝⬝⬝\"+Timestamp"
```