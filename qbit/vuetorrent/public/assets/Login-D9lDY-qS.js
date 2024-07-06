import{j as v,E as b,S as h,X as C,r as q,f as k,Y as x,a as S,H as K,I as A,J as s,n as e,K as m,L as p,u as l,M as f,O as _,Z as y}from"./vue-CfSjRv-x.js";import{_ as F,__tla as __tla_0}from"./PasswordField.vue_vue_type_script_setup_true_lang-D82vCg5_.js";import{F as T,G as B,V as I,H as M,c as O,d as U,e as E,k as H,f as L,h as N,i as R,__tla as __tla_1}from"./index-C0tfT_Qc.js";import"./vuetify-PctCzU6r.js";let Y;let __tla=Promise.all([(()=>{try{return __tla_0}catch{}})(),(()=>{try{return __tla_1}catch{}})()]).then(async()=>{Y=v({__name:"Login",setup(j){const{t:a}=b(),w=h(),o=C(),u=T(),r=q({username:"",password:""}),c=k(!1),V={username:[d=>!!d||a("login.rules.username_required")],password:[d=>!!d||a("login.rules.password_required")]},i=async()=>{c.value&&(await u.login(r.username,r.password),u.isAuthenticated?(y.success(a("login.success")),g()):y.error(a("login.error")))},g=()=>{o.query.redirect?w.push(o.query.redirect):w.push({name:"dashboard"})};return x(async()=>{o.query.username&&o.query.password&&await u.login(o.query.username,o.query.password)}),S(()=>{u.isAuthenticated&&g()}),(d,n)=>(K(),A(B,{class:"fill-height"},{default:s(()=>[e(R,{class:"mx-auto",rounded:"lg","min-width":"250"},{default:s(()=>[e(I,null,{default:s(()=>[m(p(l(a)("login.title")),1)]),_:1}),e(M,null,{default:s(()=>[m(p(l(a)("login.subtitle")),1)]),_:1}),e(O,null,{default:s(()=>[e(U,{modelValue:c.value,"onUpdate:modelValue":n[2]||(n[2]=t=>c.value=t),onSubmit:f(i,["prevent"])},{default:s(()=>[e(E,{modelValue:r.username,"onUpdate:modelValue":n[0]||(n[0]=t=>r.username=t),id:"username",name:"username",label:l(a)("login.username"),autofocus:"",rules:V.username,onKeydown:_(f(i,["prevent"]),["enter"]),variant:"outlined"},{prepend:s(()=>[e(H,{color:"accent",icon:"mdi-account"})]),_:1},8,["modelValue","label","rules","onKeydown"]),e(F,{modelValue:r.password,"onUpdate:modelValue":n[1]||(n[1]=t=>r.password=t),id:"password",label:l(a)("login.password"),rules:V.password,"prepend-icon":"mdi-lock",onKeydown:_(f(i,["prevent"]),["enter"]),variant:"outlined"},null,8,["modelValue","label","rules","onKeydown"])]),_:1},8,["modelValue"])]),_:1}),e(L,null,{default:s(()=>[e(N,{variant:"elevated",block:"",color:"accent",onClick:i},{default:s(()=>[m(p(l(a)("login.submit")),1)]),_:1})]),_:1})]),_:1})]),_:1}))}})});export{Y as default,__tla};