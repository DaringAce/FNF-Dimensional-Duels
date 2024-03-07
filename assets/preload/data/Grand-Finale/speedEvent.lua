local speed = 1
function onCreatePost() speed = getProperty('songSpeed'); end
function onStepHit()

  if curStep == 639 then
    setProperty('songSpeed', speed + 0.5);
  elseif curStep == 895 then
    setProperty('songSpeed', speed);
  end
end