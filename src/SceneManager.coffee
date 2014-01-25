class SceneManager
  constructor:->
    @scenes = {}
    @current = null

  add:(name, scene)=>
    @scenes[name] = scene    

  init:(name)=>
    @scenes[@current].fini unless @current == null
    @current = name
    @scenes[@current].init()

  update:=>
    @scenes[@current].update() unless @current == null

  get_current:()=>
    @scenes[@current]

root = exports ? window
root.SceneManager = SceneManager