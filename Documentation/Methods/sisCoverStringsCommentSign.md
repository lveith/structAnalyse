<!-- PM: "sisCoverStringsCommentSign"<< $0 - C_TEXT - Result text>> $1 - C_TEXT - srcTxtCover Strings in doubleQuotes (just comment sign "//" inner strings) -->
#### `sisCoverStringsCommentSign(srcCodeTxt4D) -> resultText`
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
      <td>Result text whith covered commentSign "//" inner content of doubleQuoteStrings</td>
    </tr>
    <tr style="color: #555; background-color: white;">
      <td style="text-align: center; font-weight: bold;">$1</td>
      <td>srcText</td>
      <td style="text-align: center;">C_TEXT</td>
      <td>Any 4D source code text</td>
    </tr>
  </tbody>
</table>

## Example
```4d
sisCoverStringsWholeContent("var:=\"a//b\"+Timestamp")
// -> "var:=\"a⬝⬝b\"+Timestamp"
```