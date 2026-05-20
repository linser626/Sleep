<template>
  <div class="moments-container">
    <div class="moments-header">
      <h2>朋友圈</h2>
    </div>
    
    <div class="moments-content">
      <div class="moment-card" v-for="moment in moments" :key="moment.id">
        <div class="moment-header">
          <img 
            :src="moment.avatar || 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + moment.userId" 
            class="moment-avatar" 
            alt="头像"
          />
          <div class="moment-user-info">
            <div class="moment-username">{{ moment.username }}</div>
            <div class="moment-time">{{ moment.time }}</div>
          </div>
        </div>
        
        <div class="moment-content">
          <p>{{ moment.content }}</p>
          <div v-if="moment.images && moment.images.length > 0" class="moment-images">
            <img 
              v-for="(img, index) in moment.images" 
              :key="index" 
              :src="img" 
              class="moment-image"
            />
          </div>
        </div>
        
        <div class="moment-stats">
          <div class="stat-item" @click="likeMoment(moment)">
            <span>{{ moment.isLiked ? '❤️' : '🤍' }}</span>
            <span>{{ moment.likeCount }}</span>
          </div>
          <div class="stat-item" @click="showComments(moment)">
            <span>💬</span>
            <span>{{ moment.commentCount }}</span>
          </div>
        </div>
        
        <div class="moment-comments" v-if="showingComments === moment.id">
          <div class="comment-item" v-for="comment in moment.comments" :key="comment.id">
            <span class="comment-author">{{ comment.author }}</span>
            <span class="comment-content">{{ comment.content }}</span>
          </div>
          
          <div class="comment-input">
            <el-input 
              v-model="newComment" 
              placeholder="写评论..." 
              @keyup.enter="addComment(moment)"
            />
            <el-button @click="addComment(moment)">发送</el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const moments = ref([
  {
    id: 1,
    userId: 1,
    username: '张三',
    avatar: '',
    content: '今天天气真好，出去散步了！🌞',
    images: ['https://picsum.photos/300/200', 'https://picsum.photos/300/200'],
    time: '2小时前',
    likeCount: 12,
    commentCount: 3,
    isLiked: false,
    comments: [
      { id: 1, author: '李四', content: '真不错！' },
      { id: 2, author: '王五', content: '羡慕啊' },
      { id: 3, author: '赵六', content: '求带' }
    ]
  },
  {
    id: 2,
    userId: 2,
    username: '李四',
    avatar: '',
    content: '周末去爬山了，风景很美！🏔️',
    images: ['https://picsum.photos/400/300'],
    time: '5小时前',
    likeCount: 25,
    commentCount: 8,
    isLiked: true,
    comments: [
      { id: 1, author: '张三', content: '太美了！' },
      { id: 2, author: '钱七', content: '这是哪里？' }
    ]
  },
  {
    id: 3,
    userId: 3,
    username: '王五',
    avatar: '',
    content: '今天学习了Vue3，感觉很棒！💪',
    images: [],
    time: '昨天',
    likeCount: 18,
    commentCount: 5,
    isLiked: false,
    comments: []
  }
])

const showingComments = ref(null)
const newComment = ref('')

const likeMoment = (moment) => {
  moment.isLiked = !moment.isLiked
  moment.likeCount += moment.isLiked ? 1 : -1
}

const showComments = (moment) => {
  showingComments.value = showingComments.value === moment.id ? null : moment.id
}

const addComment = (moment) => {
  if (!newComment.value.trim()) return
  
  moment.comments.push({
    id: Date.now(),
    author: '我',
    content: newComment.value
  })
  moment.commentCount++
  newComment.value = ''
}
</script>

<style scoped>
.moments-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: #f5f5f5;
}

.moments-header {
  padding: 16px;
  background: white;
  border-bottom: 1px solid #eee;
}

.moments-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
}

.moments-content {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
}

.moment-card {
  background: white;
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 20px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.moment-header {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
}

.moment-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  margin-right: 12px;
  object-fit: cover;
}

.moment-username {
  font-size: 15px;
  font-weight: 500;
}

.moment-time {
  font-size: 12px;
  color: #999;
}

.moment-content {
  margin-bottom: 12px;
}

.moment-content p {
  margin: 0 0 12px 0;
  font-size: 14px;
  line-height: 1.6;
}

.moment-images {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 8px;
}

.moment-image {
  width: 100%;
  aspect-ratio: 1;
  object-fit: cover;
  border-radius: 8px;
}

.moment-stats {
  display: flex;
  gap: 24px;
  padding-top: 12px;
  border-top: 1px solid #f0f0f0;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 4px;
  cursor: pointer;
  color: #666;
  font-size: 14px;
}

.stat-item:hover {
  color: #07C160;
}

.moment-comments {
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px solid #f0f0f0;
}

.comment-item {
  margin-bottom: 8px;
  padding: 8px;
  background: #f9f9f9;
  border-radius: 4px;
}

.comment-author {
  font-weight: 500;
  margin-right: 8px;
}

.comment-content {
  color: #666;
}

.comment-input {
  display: flex;
  gap: 8px;
  margin-top: 12px;
}

.comment-input .el-input {
  flex: 1;
}
</style>