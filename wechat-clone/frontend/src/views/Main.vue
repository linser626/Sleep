<template>
  <div class="main-container">
    <div class="sidebar">
      <div class="sidebar-header">
        <h1>微信</h1>
      </div>
      
      <div class="nav-list">
        <div 
          v-for="item in navItems" 
          :key="item.name"
          :class="['nav-item', { active: currentRoute === item.name }]"
          @click="navigate(item.path)"
        >
          <span class="nav-icon">{{ item.icon }}</span>
          <span class="nav-text">{{ item.label }}</span>
        </div>
      </div>
      
      <div class="sidebar-footer">
        <div class="user-info" @click="navigate('/profile')">
          <img 
            :src="user?.avatar || 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + user?.userId" 
            class="avatar" 
            alt="头像"
          />
          <span class="username">{{ user?.nickname }}</span>
        </div>
        <el-button @click="logout" class="logout-btn">退出登录</el-button>
      </div>
    </div>
    
    <div class="content-area">
      <router-view />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useUserStore } from '../stores/user'
import axios from 'axios'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

const user = ref(null)
const currentRoute = ref('ChatList')

const navItems = [
  { name: 'ChatList', label: '聊天', icon: '💬', path: '/' },
  { name: 'Moments', label: '朋友圈', icon: '📷', path: '/moments' },
  { name: 'Contacts', label: '通讯录', icon: '👥', path: '/contacts' },
  { name: 'Profile', label: '我', icon: '👤', path: '/profile' }
]

const navigate = (path) => {
  router.push(path)
}

const logout = () => {
  userStore.logout()
  router.push('/login')
}

const loadUser = async () => {
  try {
    const response = await axios.get('/api/auth/me')
    if (response.data.success) {
      user.value = response.data.data
    }
  } catch (error) {
    console.error('加载用户信息失败:', error)
  }
}

watch(() => route.name, (newName) => {
  currentRoute.value = newName || 'ChatList'
})

onMounted(() => {
  loadUser()
})
</script>

<style scoped>
.main-container {
  display: flex;
  height: 100vh;
  background: #f5f5f5;
}

.sidebar {
  width: 240px;
  background: #2d2d2d;
  color: white;
  display: flex;
  flex-direction: column;
}

.sidebar-header {
  padding: 20px;
  border-bottom: 1px solid #444;
}

.sidebar-header h1 {
  font-size: 20px;
  font-weight: 600;
  color: #07C160;
  margin: 0;
}

.nav-list {
  flex: 1;
  padding: 10px;
}

.nav-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
  margin-bottom: 4px;
}

.nav-item:hover {
  background: #3d3d3d;
}

.nav-item.active {
  background: #07C160;
}

.nav-icon {
  font-size: 20px;
  margin-right: 12px;
}

.nav-text {
  font-size: 14px;
}

.sidebar-footer {
  padding: 16px;
  border-top: 1px solid #444;
}

.user-info {
  display: flex;
  align-items: center;
  padding: 10px;
  border-radius: 8px;
  cursor: pointer;
  margin-bottom: 10px;
}

.user-info:hover {
  background: #3d3d3d;
}

.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  margin-right: 12px;
  object-fit: cover;
}

.username {
  font-size: 14px;
}

.logout-btn {
  width: 100%;
  background: transparent;
  border: 1px solid #666;
  color: #999;
}

.content-area {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}
</style>