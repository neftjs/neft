import { Struct } from '@neft/core'
import WebSocket from '@neft/websocket'
import parseStringComponentCode from '~/src/lib/parse-string-component-code'

const SERVER_WS_URL = 'wss://editor.neft.io/socket'
const CODE_LENGTH = 6

export const socket = new Struct({
  connected: false,
  component: '',
})

export const parseCode = code => code.match(/\d+/g).join('')

export const isCodeValid = code =>
  typeof code === 'string' && code.length === CODE_LENGTH

export const connectToCode = (code) => {
  const ws = new WebSocket(SERVER_WS_URL)

  ws.onopen = () => {
    ws.send(JSON.stringify({ listen: code }))
    socket.connected = true
  }

  ws.onmessage = (event) => {
    socket.component = parseStringComponentCode(event.data)
  }

  ws.onclose = () => {
    socket.connected = false
  }
}
