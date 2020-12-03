<!-- PM: "sisStartMain">> $1 - C_TEXT - CalledBy methodName, just for intern use to selfLaunch in a new process (optinal, normally do not use this)Starts 'SIS - Search-In-Structure' in own process with own dialog -->
#### `sisStartMain`
---
## Description
#### Starts the tool `SIS | Search-In-Structure` in own process with own dialog.<br>
With this method you can start the SIS-Tool with own code,<br>
but normally you use the macroMenu to start the tool without own coding.
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
      <td style="text-align: center; font-weight: bold;">$1<div style="text-align: center; font-size: 65%;"><div style="background-color: rgb(249, 242, 244); border-bottom-left-radius: 4px; border-bottom-right-radius: 4px; border-top-left-radius: 4px; border-top-right-radius: 4px; box-sizing: border-box; color: rgb(199, 37, 78); display: inline; font-family: Menlo, Monaco, Consolas, 'Courier New', monospace; height: auto; padding-bottom: 2px; padding-left: 4px; padding-right: 4px; padding-top: 2px; width: auto; font-weight: normal;">🚫</div></div></td>
      <td>calledByMethodName<div style="text-align: center;  font-size: 65%;"><div style="background-color: rgb(249, 242, 244); border-bottom-left-radius: 4px; border-bottom-right-radius: 4px; border-top-left-radius: 4px; border-top-right-radius: 4px; box-sizing: border-box; color: rgb(199, 37, 78); display: inline; font-family: Menlo, Monaco, Consolas, 'Courier New', monospace; height: auto; padding-bottom: 2px; padding-left: 4px; padding-right: 4px; padding-top: 2px; width: auto; font-weight: normal;">🚫 Do not use!</div></div></td>
      <td style="text-align: center;">C_TEXT</td>
      <td>Called by method name, just for intern use to selfLaunch this method in a new process (optinal, normally do not use this)</td>
    </tr>
  </tbody>
</table>

## Example
```4d
If (False) // Step in here with debugger to start SIS
  sisStartMain
End if
```