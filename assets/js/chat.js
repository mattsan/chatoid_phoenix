import Chat from '../src/Chat.elm'

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('elm-chat')
  Chat.Elm.Main.init({ node: element })
})
