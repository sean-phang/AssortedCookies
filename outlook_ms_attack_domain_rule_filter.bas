Attribute VB_Name = "Module1"
Sub CreateRule()
 Dim colRules As Outlook.Rules
 Dim oRule As Outlook.Rule
 
 Dim oMoveRuleAction As Outlook.MoveOrCopyRuleAction
 Dim oContainsCondition As Outlook.TextRuleCondition
 Dim oStopProcessing As Outlook.RuleAction
 
 Dim oInbox As Outlook.Folder
 Dim oMoveTarget As Outlook.Folder
 
 'Specify target folder for rule move action
 Set oInbox = Application.Session.GetDefaultFolder(olFolderInbox)
 
 'Assume that target folder already exists
 Set oMoveTarget = oInbox.Folders("PHISHING")
 
 'Get Rules from Session.DefaultStore object
 Set colRules = Application.Session.DefaultStore.GetRules()
 
 'Create the rule by adding a Receive Rule to Rules collection
 Set oRule = colRules.Create("Nice Try", olRuleReceive)
 
 'Set condition where message contains certain words
 Set oContainsCondition = oRule.Conditions.BodyOrSubject
 
 With oContainsCondition
 .Enabled = True
 .Text = Array("bankmenia.com", "bankmenia.de", "bankmenia.fr", "bankmenia.it", "bankmenia.org", "banknown.de", "banknown.fr", "banknown.it", "banknown.org", "browsersch.com", _
    "browsersch.de", "browsersch.fr", "browsersch.it", "browsersch.org", "doctorican.de", "doctorican.fr", "doctorican.it", "doctorican.org", "doctrical.com", "doctrical.de", _
    "doctrical.fr", "doctrical.it", "doctrical.org", "doctrings.com", "doctrings.de", "doctrings.fr", "doctrings.it", "doctrings.org", "exportants.com", "exportants.de", _
    "exportants.fr", "exportants.it", "exportants.org", "financerta.com", "financerta.de", "financerta.fr", "financerta.it", "financerta.org", "financerts.com", "financerts.de", _
    "financerts.fr", "financerts.it", "financerts.org", "passwordle.de", "passwordle.fr", "passwordle.it", "passwordle.org", "prizeably.com", "prizeably.de", "prizeably.fr", _
    "prizeably.it", "prizeably.org", "resetts.de", "resetts.fr", "resetts.it", "resetts.org", "securembly.com", "securembly.de", "securembly.fr", "securembly.it", _
    "securembly.org", "securetta.de", "securetta.fr", "securetta.it", "supportin.de", "supportin.fr", "supportin.it", "supportres.de", "supportres.fr", "supportres.it", _
    "supportres.org", "techidal.com", "techidal.de", "techidal.fr", "techidal.it", "techniel.de", "techniel.fr", "techniel.it", "bankmenia.es", "banknown.es", _
    "browsersch.es", "doctorican.es", "doctrical.es", "doctrings.es", "exportants.es", "financerta.es", "financerts.es", "prizeably.es", "resetts.es", "securembly.es", _
    "securetta.es", "supportin.es", "supportres.es", "techniel.es", "mcsharepoint.com", "mesharepoint.com", "officence.com", "officenced.com", "officences.com", "officentry.com", _
    "officested.com", "prizegives.com", "prizemons.com", "prizewel.com", "prizewings.com", "shareholds.com", "sharepointen.com", "sharepointin.com", "sharepointle.com", "sharesbyte.com", _
    "sharession.com", "sharestion.com", "templateau.com", "templatent.com", "templatern.com", "windocyte.com", "attemplate.com", "doctricant.com", "salarytoolint.com", "prizesforall.com", _
    "payrolltooling.com", "hrsupportint.com", "docstoreinternal.com", "docdeliveryapp.com", "docstoreinternal.net", "hardwarecheck.net", "payrolltooling.net", "prizegiveaway.net", "salarytoolint.net", _
    "docdeliveryapp.net")
 End With
 
 'Specify the action in a MoveOrCopyRuleAction object
 'Action is to move the message to the target folder
 Set oMoveRuleAction = oRule.Actions.MoveToFolder
 With oMoveRuleAction
 .Enabled = True
 .Folder = oMoveTarget
 End With
 
 ' Stop processing more rules
 Set oStopProcessing = oRule.Actions.Stop
 With oStopProcessing
    .Enabled = True
 End With
 
 'Update the server and display progress dialog
 colRules.Save
End Sub

