import Vue from 'vue'
import VueRouter from 'vue-router'
import Index from '../views/Index.vue'
import Teacher from '../views/index/teacher_views/Teacher.vue'
import Student from '../views/index/student_views/Student.vue'
import Login from '../views/index/Login.vue'

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      component: Index,
      children: [
        {
          path: '/teacher',
          name: 'teacher',
          component: Teacher,
          children: [
            {
              path: '/teacher/student',
              component: () => import('../views/index/teacher_views/Student.vue')
            },
            {
              path: '/teacher/class',
              component: () => import('../views/index/teacher_views/Class.vue')
            },
            {
              path: '/teacher/course',
              component: () => import('../views/index/teacher_views/Course.vue')
            },
            {
              path: '/teacher/grade',
              component: () => import('../views/index/teacher_views/Grade.vue')
            },
            {
              path: '/teacher/system',
              component: () => import('../views/index/teacher_views/System.vue')
            },
            // {
            //   path: '/teacher/x',
            //   component: () => import('../views/teacher_views/xinxiguanli.vue')
            // }
          ],
        },
        {
          path: '/student',
          name: 'student',
          component: Student,
          children: [
            {
              path: '/student/info',
              component: () => import('../views/index/student_views/Info.vue')
            },
            {
              path: '/student/scourse',
              component: () => import('../views/index/student_views/Scourse.vue')
            },
            {
              path: '/student/sgrade',
              component: () => import('../views/index/student_views/Sgrade.vue')
            },
            {
              path: '/student/ssystem',
              component: () => import('../views/index/student_views/Ssystem.vue')
            },
          ]
        },
        {
          path: '/login',
          name: 'login',
          component: Login
        }
      ]
    }
  ]
})

// export default new VueRouter({
//   mode: 'history',
//   base: process.env.BASE_URL,
//   // routes: [
//   //   {
//   //     path: '/app',
//   //     name: 'app',
//   //     component: App
//   //   },
//   //   {
//   //     path: '/login',
//   //     name: 'login',
//   //     component: Login
//   //   },
//   //   {
//   //     path: '/',
//   //     name: 'index',
//   //     component: Index
//   //   }
//   // ]
// })

// export default new VueRouter({
//   routes: [
//     {
//       path: '/login',
//       name: '登录',
//       component: Login
//     },
//     {
//       path: '/',
//       name: '首页',
//       component: App
//     }
//   ]
// })