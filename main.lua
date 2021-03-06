twopi = 2*math.pi;

local anim8 = require "lib/anim8"
local tween = require "lib/tween"
local gamestate = require "lib/gamestate"

local gameplay = require "gameplay"
local menu = require "menu"

local logo = require "logo"

local bckgr
local combs, combb
local combr

local theme


function love.load(arg)
  if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
  
  --globals
  t1 = love.graphics.newImage("gfx/t1.png")
  fontb = love.graphics.newFont("gfx/ecb.otf",24)
  fonts = love.graphics.newFont("gfx/ecb.otf",16)
  cross = love.graphics.newQuad(0,430,60,60,1024,1024)
  drop = love.audio.newSource("sfx/drop.wav")
  lost = love.audio.newSource("sfx/lost.wav")
  hit = love.audio.newSource("sfx/hit.wav")
  batch = love.graphics.newSpriteBatch(t1,1000)
  
  bckgr = love.graphics.newImage("gfx/tlo.png")
  combs = love.graphics.newQuad(574,724,200,300,1024,1024)
  combb = love.graphics.newQuad(774,624,250,400,1024,1024)
  combr = { rs = 0, rb = 0 }
  local rotf = function(back) tween(5, combr, {rs = 0.1, rb = 0.3}, "inOutQuad", function(back) tween(5, combr, {rs = 0, rb = 0}, "inOutQuad", back, back) end, back) end
  rotf(rotf)
  theme = love.audio.newSource("sfx/theme.mp3")
  theme:setVolume(0.3)
  love.audio.play(theme)
  
  love.mouse.setVisible(false)
  love.mouse.setGrab(true)
  
  
  gameplay:load()
  menu:load()
  
  logo:load()
  
  
  gamestate.registerEvents()
  gamestate.switch(menu)
end

function love.update(dt)
  tween.update(dt)
end

function love.draw()
  local mx, my = love.mouse.getX(), love.mouse.getY()
  local rmr = math.atan2(my-300,mx-400)
  love.graphics.draw(bckgr,0,0)
  batch:bind()
  batch:setColor(255,255,255,255)
  batch:addq(combs,400,300,0+combr.rs,1,1,390,10)
  batch:addq(combs,400,300,math.pi+0.1-combr.rs,1,1,390,10)
  batch:addq(combb,400,300,0+combr.rb,1,1,380,140)
  batch:addq(combb,400,300,math.pi+0.3-combr.rb,1,1,380,140)
  logo:draw()
end