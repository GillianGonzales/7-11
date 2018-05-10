-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Created By Gillian Gonzales
-- Created On May 10 2018
--
-- This program will combine physics and animation
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

-- Adding Physics
local physics = require( "physics" )

physics.start()
physics.setGravity(0, 50)
--physics.setDrawMode( "hybrid" )

--Adding list of bullets
local playerBullets = {}

local sheetOptionsNinjaBoyIdle =
{
    width = 232,
    height = 439,
    numFrames = 10
}
local sheetIdleNinjaBoy = graphics.newImageSheet( "./assets/spritesheets/NinjaBoyIdle.png", sheetOptionsNinjaBoyIdle )

local sheetOptionsNinjaBoyRun =
{
    width = 363,
    height = 458,
    numFrames = 10
}

local sheetRunNinjaBoy = graphics.newImageSheet( "./assets/spritesheets/NinjaBoyRun.png", sheetOptionsNinjaBoyRun )

local sheetOptionsNinjaBoyJump =
{
    width = 362,
    height = 483,
    numFrames = 10
}

local sheetJumpNinjaBoy = graphics.newImageSheet( "./assets/spritesheets/NinjaBoyJump.png", sheetOptionsNinjaBoyJump )

local sheetOptionsNinjaBoyThrow =
{
    width = 377,
    height = 451,
    numFrames = 10
}

local sheetThrowNinjaBoy = graphics.newImageSheet( "./assets/spritesheets/NinjaBoyThrow.png", sheetOptionsNinjaBoyThrow )

-- sequences table
local sequence_dataNinjaBoy = {
    -- consecutive frames sequence
    {
        name = "idle",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 0,
        sheet = sheetIdleNinjaBoy
    },
    {
     	name = "walk",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 1,
        sheet = sheetRunNinjaBoy
    },
    {   name = "jump",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 1,
        sheet = sheetJumpNinjaBoy
    },
    {   name = "throw",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 1,
        sheet = sheetThrowNinjaBoy
    }
}

local sheetOptionsRobotIdle =
{
    width = 567,
    height = 556,
    numFrames = 10
}

local sheetIdleRobot = graphics.newImageSheet( "./assets/spritesheets/robotIdle.png", sheetOptionsRobotIdle )

local sheetOptionsRobotDead =
{
    width = 562,
    height = 519,
    numFrames = 10
}

local sheetDeadRobot = graphics.newImageSheet( "./assets/spritesheets/robotDead.png", sheetOptionsRobotDead )

local sequence_dataRobot = {
    -- consecutive frames sequence
    {
        name = "idle",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 0,
        sheet = sheetIdleRobot
    },
    {
        name = "dead",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 1,
        sheet = sheetDeadRobot
    }
}
-- Adding Images

local ground1 = display.newImage("./assets/sprites/land1.png")
ground1.x = display.contentCenterX - 500
ground1.y = display.contentHeight - 400
ground1.id = "ground1"
physics.addBody( ground1, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local ground2 = display.newImage("./assets/sprites/land2.png")
ground2.x = display.contentCenterX + 500
ground2.y = display.contentHeight - 100
ground2.id = "ground2"
physics.addBody( ground2, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local Robot = display.newSprite( sheetIdleRobot, sequence_dataRobot )
Robot.x = 1520
Robot.y = display.contentHeight - 1000
Robot.id = "Robot"
physics.addBody( Robot, "dynamic", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local landSquare = display.newImage( "./assets/sprites/landSquare.png" )
landSquare.x = 620
landSquare.y = display.contentHeight - 1000
landSquare.id = "land Square"
physics.addBody( landSquare, "dynamic", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local  leftWall = display.newRect( 0, display.contentHeight / 2, 1, display.contentHeight )
leftWall.alpha = 0.0
physics.addBody( leftWall, "static",{
	friction = 0.5,
	bounce = 0.3
	} )

local NinjaBoy = display.newSprite( sheetIdleNinjaBoy, sequence_dataNinjaBoy )
NinjaBoy.x = display.contentCenterX - 800
NinjaBoy.y = display.contentCenterY - 400
NinjaBoy.id = "NinjaBoy"
physics.addBody( NinjaBoy, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3
    } )
NinjaBoy.isFixedRotation = true

local jumpButton = display.newImage( "./assets/sprites/jumpButton.png" )
jumpButton.x = display.contentWidth - 80
jumpButton.y = display.contentHeight - 80
jumpButton.id = "jump button"
jumpButton.alpha = 0.5


local dPad = display.newImage( "./assets/sprites/d-pad.png" )
dPad.x = 150
dPad.y = display.contentHeight - 150
dPad.alpha = 0.50
dPad.id = "d-pad"

local upArrow = display.newImage( "./assets/sprites/upArrow.png" )
upArrow.x = 150
upArrow.y = display.contentHeight - 260
upArrow.id = "up arrow"

local rightArrow = display.newImage( "./assets/sprites/rightArrow.png" )
rightArrow.x = 260
rightArrow.y = display.contentHeight - 150
rightArrow.id = "right arrow"

local leftArrow = display.newImage( "./assets/sprites/leftArrow.png" )
leftArrow.x = 40
leftArrow.y = display.contentHeight - 150
leftArrow.id = "left arrow"

local downArrow = display.newImage( "./assets/sprites/downArrow.png" )
downArrow.x = 150
downArrow.y = display.contentHeight - 40
downArrow.id = "down arrow"

local shootButton = display.newImage( "./assets/sprites/jumpButton.png" )
shootButton.x = display.contentWidth - 250
shootButton.y = display.contentHeight - 80
shootButton.id = "shootButton"
shootButton.alpha = 0.5

NinjaBoy:play()
Robot:play()


-- Making functions

local function characterCollision( self, event )
 
    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end

function checkingPlayerBulletsOutOfBounds()
	-- check if any bullets have gone off the screen
	local bulletCounter

    if #playerBullets > 0 then
        for bulletCounter = #playerBullets, 1 ,-1 do
            if playerBullets[bulletCounter].x > display.contentWidth + 1000 then
                playerBullets[bulletCounter]:removeSelf()
                playerBullets[bulletCounter] = nil
                table.remove(playerBullets, bulletCounter)
                print("remove bullet")
            end
        end
    end
end

local function onCollision( event )
 
    if ( event.phase == "began" ) then
 
        local obj1 = event.object1
        local obj2 = event.object2
        local whereCollisonOccurredX = obj1.x
        local whereCollisonOccurredY = obj1.y

        if ( ( obj1.id == "Robot" and obj2.id == "bullet" ) or
             ( obj1.id == "bullet" and obj2.id == "Robot" ) ) then

            for bulletCounter = #playerBullets, 1, -1 do
                if ( playerBullets[bulletCounter] == obj1 or playerBullets[bulletCounter] == obj2 ) then
                	playerBullets[bulletCounter]:removeSelf()
                    playerBullets[bulletCounter] = nil
                    table.remove( playerBullets, bulletCounter )
                    break
                end
            end

            --death animation
        	Robot:setSequence( "dead" )
        	Robot:play()
        	transition.fadeOut( Robot, { time=2000 } )


            -- Increase score
            print ("you could increase a score here.")

            -- make an explosion sound effect
            local expolsionSound = audio.loadStream( "./assets/sounds/8bit_bomb_explosion.wav" )
            local explosionChannel = audio.play( expolsionSound )

             -- make an explosion happen
            -- Table of emitter parameters
			local emitterParams = {
			    startColorAlpha = 1,
			    startParticleSizeVariance = 250,
			    startColorGreen = 0.3031555,
			    yCoordFlipped = -1,
			    blendFuncSource = 770,
			    rotatePerSecondVariance = 153.95,
			    particleLifespan = 0.7237,
			    tangentialAcceleration = -1440.74,
			    finishColorBlue = 0.3699196,
			    finishColorGreen = 0.5443883,
			    blendFuncDestination = 1,
			    startParticleSize = 400.95,
			    startColorRed = 0.8373094,
			    textureFileName = "./assets/sprites/fire.png",
			    startColorVarianceAlpha = 1,
			    maxParticles = 256,
			    finishParticleSize = 540,
			    duration = 0.25,
			    finishColorRed = 1,
			    maxRadiusVariance = 72.63,
			    finishParticleSizeVariance = 250,
			    gravityy = -671.05,
			    speedVariance = 90.79,
			    tangentialAccelVariance = -420.11,
			    angleVariance = -142.62,
			    angle = -244.11
			}
			local emitter = display.newEmitter( emitterParams )
			emitter.x = whereCollisonOccurredX
			emitter.y = whereCollisonOccurredY

        end
    end
end


function upArrow:touch( event )
	-- This function will move the character up
    if ( event.phase == "ended" ) then
        transition.moveBy( NinjaBoy, { 
        	x = 0, 
        	y = -50, 
        	time = 100 
        	} )
    end

    return true
end

function rightArrow:touch( event )
	-- This function will move the character to the right
    if ( event.phase == "ended" ) then
        transition.moveBy( NinjaBoy, { 
        	x = 200, 
        	y = 0, 
        	time = 400 
        	} )
        NinjaBoy:setSequence( "walk" )
        NinjaBoy:play()
    end

    return true
end

function leftArrow:touch( event )
	-- This function will move the character to the left
    if ( event.phase == "ended" ) then
        transition.moveBy( NinjaBoy, { 
        	x = -50, 
        	y = 0, 
        	time = 100 
        	} )
    end

    return true
end

function downArrow:touch( event )
	-- This function will move the character down
    if ( event.phase == "ended" ) then
        transition.moveBy( NinjaBoy, { 
        	x = 0, 
        	y = 50, 
        	time = 100 
        	} )
    end

    return true
end

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- make the character jump
        NinjaBoy:setLinearVelocity( 0, -750 )
        NinjaBoy:setSequence( "jump" )
        NinjaBoy:play()
    end

    return true
end

function checkCharacterPosition( event )
    -- check every frame to see if character has fallen
    if NinjaBoy.y > display.contentHeight + 500 then
        NinjaBoy.x = display.contentCenterX - 200
        NinjaBoy.y = display.contentCenterY
    end
end

function shootButton:touch( event )
    if ( event.phase == "began" ) then
        -- make a bullet appear
        local aSingleBullet = display.newImage( "./assets/sprites/Kunai.png" )
        aSingleBullet.x = NinjaBoy.x
        aSingleBullet.y = NinjaBoy.y
        physics.addBody( aSingleBullet, 'dynamic' )
        -- Make the object a "bullet" type object
        aSingleBullet.isBullet = true
        aSingleBullet.gravityScale = 0
        aSingleBullet.id = "bullet"
        aSingleBullet:setLinearVelocity( 1500, 0 )
        aSingleBullet.isFixedRotation = true

        table.insert(playerBullets,aSingleBullet)
        print("# of bullet: " .. tostring(#playerBullets))

        NinjaBoy:setSequence( "throw" )
        NinjaBoy:play()
    end

    return true
end

local function resetToIdleNinjaBoy (event)
    if event.phase == "ended" then
        NinjaBoy:setSequence("idle")
        NinjaBoy:play()
    end
end

-- Touch Events 
upArrow:addEventListener( "touch", upArrow )
rightArrow:addEventListener( "touch", rightArrow )
leftArrow:addEventListener( "touch", leftArrow )
downArrow:addEventListener( "touch", downArrow )
jumpButton:addEventListener( "touch", jumpButton )
shootButton:addEventListener( "touch", shootButton )

--Runtime Events
Runtime:addEventListener( "enterFrame", checkCharacterPosition )
Runtime:addEventListener( "enterFrame", checkingPlayerBulletsOutOfBounds )
Runtime:addEventListener( "collision", onCollision )

NinjaBoy.collision = characterCollision
NinjaBoy:addEventListener( "collision" )

--Sprite Events
NinjaBoy:addEventListener("sprite", resetToIdleNinjaBoy)
