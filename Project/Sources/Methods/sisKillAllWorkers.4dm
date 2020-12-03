//%attributes = {}
  // PM: "sisKillAllWorkers" (new LV 24.07.20, 19:41:10)
  // Kills all 'SIS' workers
  // Last change: LV 24.07.20, 19:41:10

Use (Form:C1466.run)
	Form:C1466.run.run:=False:C215
End use 

KILL WORKER:C1390("sisWorkerSearchAllMethods")
KILL WORKER:C1390("sisWorkerSearchPfMethods")
KILL WORKER:C1390("sisWorkerSearchTfMethods")
KILL WORKER:C1390("sisWorkerSearchPmMethods")
KILL WORKER:C1390("sisWorkerSearchCsMethods")
KILL WORKER:C1390("sisWorkerSearchDbMethods")
KILL WORKER:C1390("sisWorkerSearchTrigMethods")

  //KILL WORKER("sisWorkerSearchMainSub_pf")
  //KILL WORKER("sisWorkerSearchMainSub_tf")
  //KILL WORKER("sisWorkerSearchMainSub_pm")
  //KILL WORKER("sisWorkerSearchMainSub_cs")
  //KILL WORKER("sisWorkerSearchMainSub_db")
  //KILL WORKER("sisWorkerSearchMainSub_trig")
  //KILL WORKER("sisWorkerSearchMainSub_all")

KILL WORKER:C1390("sisWorkerSearchMain")
KILL WORKER:C1390("sisWorkerInsertText")

  // - EOF -