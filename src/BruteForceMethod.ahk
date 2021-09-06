#NoEnv
CoordMode, Pixel, Screen
#n:: Run SciTE4AutoHotkey



;===========================GLOBALS====================;
HasBeenCleared = false
;===========================GLOBALS====================;

;===========================FUNCTIONS====================;
BruteForceTiles()
{
	ClickArray := []
	ClearedTilesArray := []
	untouchedTile = 0x29B1FF
	hoveredTile = 0x2086C4
	greyTile = 0x3E3E3E
	blueTile = 0xEBA405
	xOrigin = 0
	yOrigin = 0
	xEnd = 1920
	yEnd = 1080
		while(!HasBeenCleared)
		{
			PixelSearch, xLocation, yLocation, xOrigin, yOrigin, xEnd, yEnd, untouchedTile, 0, Fast 
			offsetX  := xLocation + 20
			offsetY := yLocation + 15
			CurrentLocation := [offsetX, offsetY]
			ClearedTilesArray.Push(CurrentLocation)
			if (ErrorLevel == 0)
			{
				Click, %offsetX% , %offsetY%, Right
				Sleep, 500
				PixelGetColor, CurrentTile, %offsetX%, %offsetY%
				if(ErrorLevel == 0)
				{
					if (CurrentTile = 0x3E3E3E)
					{
						ClickArray.Push("Right")
					}
					else
					{
						Click, %offsetX% , %offsetY%, Left
						Sleep, 100
						PixelGetColor, CurrentTile, %offsetX%, %offsetY%
						if(ErrorLevel == 0)
						{
							if(CurrentTile = 0xEBA405)
							{
								ClickArray.Push("Left")
							}
							else
							{
								ClickArray.Push("Right")
							}
						}
						else
						{
							MsgBox, left    get pixel color failed	
						}
					}
				}
				else
				{
					MsgBox, right     get pixel color failed
				}
			}
			else
			{
				Sleep, 1000
				Click, 603, 861, Left
				HasBeenCleared = true
			}
		}
	Sleep, 2500
	for index, element in ClearedTilesArray
	{
		tempX := ClearedTilesArray[index][1]
		tempY := ClearedTilesArray[index][2]
		tempClick := ClickArray[index]
		Click, %tempX% , %tempY% , %tempClick%
	}
	return
}
;===========================FUNCTIONS====================;
^!b::
	BruteForceTiles()
return