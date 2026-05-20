<template>
  <div class="profile-container">
    <div class="profile-header">
      <div class="user-card">
        <img 
          :src="user?.avatar || 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + user?.userId" 
          class="user-avatar" 
          alt="头像"
        />
        <div class="user-info">
          <div class="user-name">{{ user?.nickname }}</div>
          <div class="user-id">ID: {{ user?.userId }}</div>
        </div>
        <button class="edit-btn">编辑资料</button>
      </div>
    </div>
    
    <div class="profile-menu">
      <div class="menu-section">
        <div class="menu-item" @click="openMyMoments">
          <span class="menu-icon">📷</span>
          <span class="menu-text">我的朋友圈</span>
          <span class="menu-arrow">›</span>
        </div>
        
        <div class="menu-item" @click="openQRCode">
          <span class="menu-icon">📱</span>
          <span class="menu-text">二维码名片</span>
          <span class="menu-arrow">›</span>
        </div>
        
        <div class="menu-item" @click="openPay">
          <span class="menu-icon">💳</span>
          <span class="menu-text">支付</span>
          <span class="menu-arrow">›</span>
        </div>
        
        <div class="menu-item" @click="openWallet">
          <span class="menu-icon">👛</span>
          <span class="menu-text">钱包</span>
          <span class="menu-arrow">›</span>
        </div>
      </div>
      
      <div class="menu-section">
        <div class="menu-item" @click="openSettings">
          <span class="menu-icon">⚙️</span>
          <span class="menu-text">设置</span>
          <span class="menu-arrow">›</span>
        </div>
        
        <div class="menu-item" @click="openHelp">
          <span class="menu-icon">❓</span>
          <span class="menu-text">帮助与反馈</span>
          <span class="menu-arrow">›</span>
        </div>
      </div>
    </div>
    
    <div class="logout-section">
      <el-button @click="logout" class="logout-btn">退出登录</el-button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'
import axios from 'axios'

const router = useRouter()
const userStore = useUserStore()

const user = ref({
  userId: 1,
  nickname: '用户',
  avatar: '',
  phone: '138****1234'
})

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

const logout = () => {
  userStore.logout()
  router.push('/login')
}

const openMyMoments = () => {
  router.push('/moments')
}

const openQRCode = () => {
  alert('二维码名片功能开发中...')
}

const openPay = () => {
  alert('支付功能开发中...')
}

const openWallet = () => {
  alert('钱包功能开发中...')
}

const openSettings = () => {
  alert('设置功能开发中...')
}

const openHelp = () => {
  alert('帮助与反馈功能开发中...')
}

onMounted(() => {
  loadUser()
})
</script>

<style scoped>
.profile-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: #f5f5f5;
}

.profile-header {
  background: linear-gradient(135deg, #07C160 0%, #10B981 100%);
  padding: 30px 20px;
}

.user-card {
  display: flex;
  align-items: center;
  background: white;
  padding: 20px;
  border-radius: 12px;
}

.user-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  margin-right: 16px;
  object-fit: cover;
  border: 3px solid #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.user-info {
  flex: 1;
}

.user-name {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 8px;
}

.user-id {
  font-size: 14px;
  color: #999;
}

.edit-btn {
  background: transparent;
  border: 1px solid #07C160;
  color: #07C160;
  padding: 8px 16px;
  border-radius: 20px;
  cursor: pointer;
  font-size: 14px;
}

.profile-menu {
  flex: 1;
  padding: 20px;
}

.menu-section {
  background: white;
  border-radius: 8px;
  margin-bottom: 12px;
  overflow: hidden;
}

.menu-item {
  display: flex;
  align-items: center;
  padding: 16px;
  cursor: pointer;
  transition: background 0.2s;
  border-bottom: 1px solid #f0f0f0;
}

.menu-item:last-child {
  border-bottom: none;
}

.menu-item:hover {
  background: #f9f9f9;
}

.menu-icon {
  font-size: 24px;
  margin-right: 12px;
}

.menu-text {
  flex: 1;
  font-size: 15px;
}

.menu-arrow {
  color: #ccc;
  font-size: 18px;
}

.logout-section {
  padding: 20px;
}

.logout-btn {
  width: 100%;
  background: transparent;
  border: 1px solid #ddd;
  color: #666;
  padding: 12px;
  border-radius: 8px;
}
</style>