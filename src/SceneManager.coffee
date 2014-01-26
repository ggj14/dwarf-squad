class SceneManager
  constructor:->
    @scenes = {}
    @current = null

  add:(name, scene)=>
    @scenes[name] = scene    

  init:(name)=>
    unless @current == null
      faders = @scenes[@current].faders
      @scenes[@current].fini()
      @scenes[@current].faders = null
    @current = name
    @scenes[@current].faders = faders
    @scenes[@current].init()

  update:=>
    @scenes[@current].update() unless @current == null

  get_current:()=>
    @scenes[@current]

root = exports ? window
root.SceneManager = SceneManager