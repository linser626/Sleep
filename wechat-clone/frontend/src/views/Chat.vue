<template>
  <div class="chat-container">
    <div class="chat-header">
      <div class="contact-info">
        <img 
          :src="contact?.avatar || 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + contactId" 
          class="contact-avatar" 
          alt="头像"
        />
        <div class="contact-detail">
          <div class="contact-name">{{ contact?.name }}</div>
          <div class="contact-status">在线</div>
        </div>
      </div>
      <div class="header-actions">
        <button class="action-btn">⋮</button>
      </div>
    </div>
    
    <div class="chat-messages" ref="messagesContainer">
      <div 
        v-for="msg in messages" 
        :key="msg.id"
        :class="['message-item', { 'is-self': msg.isSelf }]"
      >
        <img 
          :src="msg.isSelf ? userAvatar : (contact?.avatar || 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + contactId)" 
          class="message-avatar" 
          alt="头像"
        />
        <div class="message-content">
          <div class="message-bubble">
            <span v-if="msg.type === 'text'">{{ msg.content }}</span>
            <img v-else-if="msg.type === 'image'" :src="msg.content" class="message-image" />
            <span v-else-if="msg.type === 'emoji'" class="emoji">{{ msg.content }}</span>
          </div>
          <div class="message-time">{{ msg.time }}</div>
        </div>
      </div>
    </div>
    
    <div class="chat-input-area">
      <div class="input-tools">
        <button class="tool-btn" @click="showEmoji = !showEmoji">😊</button>
        <button class="tool-btn" @click="selectImage">📷</button>
        <button class="tool-btn">📁</button>
      </div>
      
      <div class="emoji-panel" v-if="showEmoji">
        <span 
          v-for="emoji in emojis" 
          :key="emoji" 
          class="emoji-item"
          @click="sendEmoji(emoji)"
        >{{ emoji }}</span>
      </div>
      
      <div class="input-area">
        <el-input 
          v-model="inputMessage" 
          placeholder="输入消息..." 
          @keyup.enter="sendMessage"
        />
        <el-button type="primary" @click="sendMessage" class="send-btn">发送</el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

const contactId = ref(route.params.id)
const contact = ref({
  name: '张三',
  avatar: ''
})

const messages = ref([
  { id: 1, content: '你好！', isSelf: false, time: '10:00', type: 'text' },
  { id: 2, content: '你好！最近忙什么呢？', isSelf: true, time: '10:01', type: 'text' },
  { id: 3, content: '在开发一个微信PC端的项目', isSelf: false, time: '10:02', type: 'text' },
  { id: 4, content: '真棒！🎉', isSelf: true, time: '10:03', type: 'emoji' },
  { id: 5, content: '谢谢！', isSelf: false, time: '10:04', type: 'text' },
  { id: 6, content: 'https://example.com/image.jpg', isSelf: false, time: '10:05', type: 'image' }
])

const inputMessage = ref('')
const showEmoji = ref(false)
const messagesContainer = ref(null)
const userAvatar = ref('')

const emojis = [
  '😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂',
  '🙂', '😊', '😇', '🥰', '😍', '🤩', '😘', '😗',
  '😚', '😋', '😛', '😜', '🤪', '😝', '🤑', '🤗',
  '🤭', '🤫', '🤔', '🤐', '🤨', '😐', '😑', '😶'
]

const sendMessage = () => {
  if (!inputMessage.value.trim()) return
  
  messages.value.push({
    id: Date.now(),
    content: inputMessage.value,
    isSelf: true,
    time: new Date().toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' }),
    type: 'text'
  })
  
  inputMessage.value = ''
  scrollToBottom()
}

const sendEmoji = (emoji) => {
  messages.value.push({
    id: Date.now(),
    content: emoji,
    isSelf: true,
    time: new Date().toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' }),
    type: 'emoji'
  })
  scrollToBottom()
}

const selectImage = () => {
  alert('图片选择功能开发中...')
}

const scrollToBottom = () => {
  nextTick(() => {
    if (messagesContainer.value) {
      messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
    }
  })
}

onMounted(() => {
  scrollToBottom()
})
</script>

<style scoped>
.chat-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: #e5ddd5;
}

.chat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: white;
  border-bottom: 1px solid #eee;
}

.contact-info {
  display: flex;
  align-items: center;
}

.contact-avatar {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  margin-right: 12px;
  object-fit: cover;
}

.contact-name {
  font-size: 16px;
  font-weight: 500;
}

.contact-status {
  font-size: 12px;
  color: #07C160;
}

.header-actions {
  display: flex;
  gap: 12px;
}

.action-btn {
  background: transparent;
  border: none;
  font-size: 20px;
  cursor: pointer;
  color: #666;
}

.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
}

.message-item {
  display: flex;
  margin-bottom: 16px;
}

.message-item.is-self {
  flex-direction: row-reverse;
}

.message-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.message-item.is-self .message-avatar {
  margin-left: 12px;
}

.message-item:not(.is-self) .message-avatar {
  margin-right: 12px;
}

.message-content {
  max-width: 60%;
}

.message-bubble {
  background: white;
  padding: 10px 14px;
  border-radius: 18px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  word-break: break-word;
}

.message-item.is-self .message-bubble {
  background: #07C160;
  color: white;
  border-radius: 18px;
}

.message-image {
  max-width: 200px;
  max-height: 200px;
  border-radius: 8px;
}

.emoji {
  font-size: 24px;
}

.message-time {
  font-size: 11px;
  color: #999;
  margin-top: 4px;
}

.message-item.is-self .message-time {
  text-align: right;
}

.chat-input-area {
  background: white;
  padding: 12px;
  border-top: 1px solid #eee;
}

.input-tools {
  display: flex;
  gap: 16px;
  margin-bottom: 12px;
}

.tool-btn {
  background: transparent;
  border: none;
  font-size: 24px;
  cursor: pointer;
  padding: 4px;
}

.emoji-panel {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding: 12px;
  background: #f9f9f9;
  border-radius: 8px;
  margin-bottom: 12px;
}

.emoji-item {
  font-size: 28px;
  cursor: pointer;
  padding: 4px;
  border-radius: 6px;
}

.emoji-item:hover {
  background: #eee;
}

.input-area {
  display: flex;
  gap: 12px;
}

.input-area .el-input {
  flex: 1;
  border-radius: 20px;
}

.send-btn {
  border-radius: 20px;
  padding: 0 24px;
  background: #07C160;
  border: none;
}
</style>