import {Socket} from "phoenix"
import Chat from '../src/Chat.elm'

const socket = new Socket("/socket", {params: {token: window.userToken}})
socket.connect()

// Now that you are connected, you can join channels with a topic:
const channel = socket.channel("room:lobby", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('elm-chat')
  const chat = Chat.Elm.Chat.init({ node: element })

  chat.ports.postItem.subscribe(item =>
    channel.push("post_item", { item })
  )

  channel.on("post_item", payload => {
    chat.ports.received.send(payload)
  })
})
