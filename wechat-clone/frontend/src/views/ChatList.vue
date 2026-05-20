<template>
  <div class="chat-list-container">
    <div class="search-bar">
      <el-input 
        v-model="searchKeyword" 
        placeholder="搜索聊天" 
        prefix-icon="el-icon-search"
      />
    </div>
    
    <div class="chat-tabs">
      <div 
        :class="['tab', { active: activeTab === 'chat' }]"
        @click="activeTab = 'chat'"
      >
        聊天
      </div>
      <div 
        :class="['tab', { active: activeTab === 'group' }]"
        @click="activeTab = 'group'"
      >
        群聊
      </div>
    </div>
    
    <div class="chat-list">
      <div 
        v-for="chat in filteredChats" 
        :key="chat.id"
        class="chat-item"
        @click="openChat(chat)"
      >
        <img 
          :src="chat.avatar || 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + chat.id" 
          class="chat-avatar" 
          alt="头像"
        />
        <div class="chat-info">
          <div class="chat-name">{{ chat.name }}</div>
          <div class="chat-preview">{{ chat.preview }}</div>
        </div>
        <div class="chat-meta">
          <div class="chat-time">{{ chat.time }}</div>
          <div v-if="chat.unread > 0" class="unread-badge">{{ chat.unread }}</div>
        </div>
      </div>
      
      <div v-if="filteredChats.length === 0" class="empty-state">
        <span class="empty-icon">💬</span>
        <p>暂无聊天记录</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()

const searchKeyword = ref('')
const activeTab = ref('chat')

const mockChats = ref([
  { id: 1, name: '张三', avatar: '', preview: '今天天气真好', time: '10:30', unread: 2, type: 'chat' },
  { id: 2, name: '李四', avatar: '', preview: '周末一起去爬山吧', time: '昨天', unread: 0, type: 'chat' },
  { id: 3, name: '王五', avatar: '', preview: '[图片]', time: '昨天', unread: 1, type: 'chat' },
  { id: 4, name: '同事群', avatar: '', preview: '明天开会时间改到下午', time: '14:20', unread: 5, type: 'group' },
  { id: 5, name: '家人群', avatar: '', preview: '记得回家吃饭', time: '12:00', unread: 0, type: 'group' },
  { id: 6, name: '老同学', avatar: '', preview: '好久不见', time: '周一', unread: 0, type: 'chat' }
])

const filteredChats = computed(() => {
  let chats = mockChats.value
  
  if (activeTab.value === 'chat') {
    chats = chats.filter(c => c.type === 'chat')
  } else {
    chats = chats.filter(c => c.type === 'group')
  }
  
  if (searchKeyword.value) {
    const keyword = searchKeyword.value.toLowerCase()
    chats = chats.filter(c => c.name.toLowerCase().includes(keyword))
  }
  
  return chats
})

const openChat = (chat) => {
  router.push(`/chat/${chat.id}`)
}
</script>

<style scoped>
.chat-list-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: white;
}

.search-bar {
  padding: 12px;
  border-bottom: 1px solid #eee;
}

.search-bar .el-input {
  border-radius: 20px;
  background: #f5f5f5;
}

.chat-tabs {
  display: flex;
  border-bottom: 1px solid #eee;
}

.tab {
  flex: 1;
  padding: 12px;
  text-align: center;
  cursor: pointer;
  font-size: 14px;
  color: #666;
  position: relative;
}

.tab.active {
  color: #07C160;
}

.tab.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 30px;
  height: 2px;
  background: #07C160;
}

.chat-list {
  flex: 1;
  overflow-y: auto;
}

.chat-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  cursor: pointer;
  border-bottom: 1px solid #f0f0f0;
  transition: background 0.2s;
}

.chat-item:hover {
  background: #f9f9f9;
}

.chat-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  margin-right: 12px;
  object-fit: cover;
}

.chat-info {
  flex: 1;
  overflow: hidden;
}

.chat-name {
  font-size: 15px;
  font-weight: 500;
  margin-bottom: 4px;
}

.chat-preview {
  font-size: 13px;
  color: #999;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.chat-meta {
  text-align: right;
}

.chat-time {
  font-size: 12px;
  color: #999;
  margin-bottom: 4px;
}

.unread-badge {
  background: #f53f3f;
  color: white;
  font-size: 12px;
  padding: 2px 6px;
  border-radius: 10px;
  min-width: 20px;
  text-align: center;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px;
  color: #999;
}

.empty-icon {
  font-size: 64px;
  margin-bottom: 20px;
}
</style>