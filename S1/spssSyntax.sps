* Encoding: UTF-8.

USE ALL.
Compute filter_$=((Include = 1 or include = 2) & ParticipantRace = 1).
VARIABLE LABELS filter_$ '(Include = 1 or include = 2) & ParticipantRace = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE

GLM AvgCommonBlackSES AvgCommonBlackHostile AvgCommonBlackOther AvgCommonBlackNeutral AvgCommonWhiteSES 
    AvgCommonWhiteHostile AvgCommonWhiteOther AvgCommonWhiteNeutral BY Condition
  /WSFACTOR=Race 2 Polynomial Stereotype 4 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Race Stereotype Race*Stereotype
  /DESIGN=Condition.

GLM AvgCommonBlackSES AvgCommonBlackHostile AvgCommonBlackOther AvgCommonBlackNeutral BY Condition
  /WSFACTOR=Stereotype 4 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Stereotype 
  /DESIGN=Condition.

GLM AvgCommonWhiteSES AvgCommonWhiteHostile AvgCommonWhiteOther AvgCommonWhiteNeutral BY Condition
  /WSFACTOR=Stereotype 4 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Stereotype 
  /DESIGN=Condition.

GLM AvgPersonalBlackSES AvgPersonalBlackHostile AvgPersonalBlackOther AvgPersonalBlackNeutral AvgPersonalWhiteSES 
    AvgPersonalWhiteHostile AvgPersonalWhiteOther AvgPersonalWhiteNeutral BY Condition
  /WSFACTOR=Race 2 Polynomial Stereotype 4 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Race Stereotype Race*Stereotype
  /DESIGN=Condition.

GLM AvgPersonalBlackSES AvgPersonalBlackHostile AvgPersonalBlackOther AvgPersonalBlackNeutral BY Condition
  /WSFACTOR=Stereotype 4 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Stereotype 
  /DESIGN=Condition.

GLM AvgPersonalWhiteSES AvgPersonalWhiteHostile AvgPersonalWhiteOther AvgPersonalWhiteNeutral BY Condition
  /WSFACTOR=Stereotype 4 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Stereotype 
  /DESIGN=Condition.

T-TEST GROUPS=Condition(.0 1)
    /MISSING=ANALYSIS
    /VARIABLES=AvgCommonBlackSES AvgCommonBlackHostile AvgCommonBlackOther AvgCommonBlackNeutral
    /CRITERIA=CI(.95).


