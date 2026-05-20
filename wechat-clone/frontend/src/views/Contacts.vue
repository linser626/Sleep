<template>
  <div class="contacts-container">
    <div class="contacts-header">
      <h2>通讯录</h2>
      <button class="add-btn" @click="showAddModal = true">+ 添加朋友</button>
    </div>
    
    <div class="contacts-search">
      <el-input 
        v-model="searchKeyword" 
        placeholder="搜索联系人" 
        prefix-icon="el-icon-search"
      />
    </div>
    
    <div class="contacts-list">
      <div 
        v-for="contact in filteredContacts" 
        :key="contact.id"
        class="contact-item"
        @click="openChat(contact)"
      >
        <img 
          :src="contact.avatar || 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + contact.id" 
          class="contact-avatar" 
          alt="头像"
        />
        <div class="contact-info">
          <div class="contact-name">{{ contact.name }}</div>
          <div class="contact-phone">{{ contact.phone }}</div>
        </div>
        <div class="contact-actions">
          <button class="action-btn" @click.stop="showContactMenu(contact)">⋮</button>
        </div>
      </div>
      
      <div v-if="filteredContacts.length === 0" class="empty-state">
        <span class="empty-icon">👥</span>
        <p>暂无联系人</p>
      </div>
    </div>
    
    <div class="contact-groups">
      <div class="group-section">
        <div class="group-header">我的群聊</div>
        <div 
          v-for="group in groups" 
          :key="group.id"
          class="group-item"
          @click="openChat(group)"
        >
          <div class="group-avatar">{{ group.memberCount }}</div>
          <div class="group-info">
            <div class="group-name">{{ group.name }}</div>
            <div class="group-members">{{ group.members }}</div>
          </div>
        </div>
      </div>
    </div>
    
    <el-dialog title="添加朋友" v-model="showAddModal" @close="showAddModal = false">
      <el-form :model="addForm">
        <el-form-item label="手机号">
          <el-input v-model="addForm.phone" placeholder="输入对方手机号" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showAddModal = false">取消</el-button>
        <el-button type="primary" @click="addFriend">添加</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const searchKeyword = ref('')
const showAddModal = ref(false)
const addForm = ref({
  phone: ''
})

const contacts = ref([
  { id: 1, name: '张三', phone: '138****1234', avatar: '' },
  { id: 2, name: '李四', phone: '139****5678', avatar: '' },
  { id: 3, name: '王五', phone: '137****9012', avatar: '' },
  { id: 4, name: '赵六', phone: '136****3456', avatar: '' },
  { id: 5, name: '钱七', phone: '135****7890', avatar: '' }
])

const groups = ref([
  { id: 101, name: '同事群', memberCount: 8, members: '张三、李四、王五等8人' },
  { id: 102, name: '家人群', memberCount: 5, members: '爸爸、妈妈、姐姐等5人' },
  { id: 103, name: '老同学', memberCount: 20, members: '班长、学习委员等20人' }
])

const filteredContacts = computed(() => {
  if (!searchKeyword.value) {
    return contacts.value
  }
  const keyword = searchKeyword.value.toLowerCase()
  return contacts.value.filter(c => 
    c.name.toLowerCase().includes(keyword) || 
    c.phone.includes(keyword)
  )
})

const openChat = (item) => {
  router.push(`/chat/${item.id}`)
}

const showContactMenu = (contact) => {
  alert(`联系人菜单: ${contact.name}`)
}

const addFriend = async () => {
  alert(`添加好友: ${addForm.value.phone}`)
  showAddModal.value = false
  addForm.value.phone = ''
}
</script>

<style scoped>
.contacts-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: #f5f5f5;
}

.contacts-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: white;
  border-bottom: 1px solid #eee;
}

.contacts-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
}

.add-btn {
  background: #07C160;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 20px;
  cursor: pointer;
  font-size: 14px;
}

.contacts-search {
  padding: 12px;
  background: white;
  border-bottom: 1px solid #eee;
}

.contacts-search .el-input {
  border-radius: 20px;
  background: #f5f5f5;
}

.contacts-list {
  flex: 1;
  overflow-y: auto;
  padding: 12px;
}

.contact-item {
  display: flex;
  align-items: center;
  padding: 12px;
  background: white;
  border-radius: 8px;
  margin-bottom: 8px;
  cursor: pointer;
  transition: background 0.2s;
}

.contact-item:hover {
  background: #f9f9f9;
}

.contact-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  margin-right: 12px;
  object-fit: cover;
}

.contact-info {
  flex: 1;
}

.contact-name {
  font-size: 15px;
  font-weight: 500;
  margin-bottom: 4px;
}

.contact-phone {
  font-size: 13px;
  color: #999;
}

.contact-actions {
  margin-left: 12px;
}

.action-btn {
  background: transparent;
  border: none;
  font-size: 18px;
  cursor: pointer;
  color: #999;
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

.contact-groups {
  padding: 12px;
  border-top: 1px solid #eee;
}

.group-section {
  background: white;
  border-radius: 8px;
  overflow: hidden;
}

.group-header {
  padding: 12px;
  font-size: 13px;
  color: #999;
  border-bottom: 1px solid #f0f0f0;
}

.group-item {
  display: flex;
  align-items: center;
  padding: 12px;
  cursor: pointer;
  transition: background 0.2s;
}

.group-item:hover {
  background: #f9f9f9;
}

.group-avatar {
  width: 48px;
  height: 48px;
  border-radius: 8px;
  background: #07C160;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 500;
  margin-right: 12px;
}

.group-info {
  flex: 1;
}

.group-name {
  font-size: 15px;
  font-weight: 500;
  margin-bottom: 4px;
}

.group-members {
  font-size: 13px;
  color: #999;
}
</style>