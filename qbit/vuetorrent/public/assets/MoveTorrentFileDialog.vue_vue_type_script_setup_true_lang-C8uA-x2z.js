import{j as I,E as S,f as u,r as h,G as x,x as g,H as F,I as T,J as t,n as l,K as m,L as f,u as V,M as B,N as D,O as M,P as O}from"./vue-CfSjRv-x.js";import{a as $,b as K,V as U,c as j,d as P,e as b,f as R,g as _,h as C,i as q,j as A,__tla as __tla_0}from"./index-C0tfT_Qc.js";let H;let __tla=Promise.all([(()=>{try{return __tla_0}catch{}})()]).then(async()=>{H=I({__name:"MoveTorrentFileDialog",props:{guid:{},hash:{},isFolder:{type:Boolean},oldName:{}},setup(k){const o=k,{isOpened:r}=$(o.guid),{t:c}=S(),N=K(),p=u(),i=u(),d=u(!1),n=h({newName:""}),y=[e=>!!e||c("dialogs.moveTorrent.required")];async function v(){await p.value?.validate(),d.value&&(o.isFolder?await N.renameTorrentFolder(o.hash,o.oldName,n.newName):await N.renameTorrentFile(o.hash,o.oldName,n.newName),w())}const w=()=>{r.value=!1};return x(()=>{if(n.newName=o.oldName,o.isFolder)g(()=>i.value?.select());else{const e=n.newName.lastIndexOf("/"),a=n.newName.lastIndexOf(".");g(()=>{i.value?.setSelectionRange(e+1,a==-1?n.newName.length:a)})}}),(e,a)=>(F(),T(A,{modelValue:V(r),"onUpdate:modelValue":a[3]||(a[3]=s=>O(r)?r.value=s:null)},{default:t(()=>[l(q,null,{default:t(()=>[l(U,null,{default:t(()=>[m(f(V(c)("dialogs.moveTorrentFile.title",1+Number(e.isFolder))),1)]),_:1}),l(j,null,{default:t(()=>[l(V(P),{modelValue:d.value,"onUpdate:modelValue":a[1]||(a[1]=s=>d.value=s),ref_key:"form",ref:p,onSubmit:a[2]||(a[2]=B(()=>{},["prevent"]))},{default:t(()=>[e.oldName?(F(),T(b,{key:0,"model-value":e.oldName,disabled:"",label:e.$t("dialogs.moveTorrentFile.oldName")},null,8,["model-value","label"])):D("",!0),l(b,{modelValue:n.newName,"onUpdate:modelValue":a[0]||(a[0]=s=>n.newName=s),ref_key:"input",ref:i,rules:y,autofocus:"",label:e.$t("dialogs.moveTorrent.newPath"),onKeydown:M(v,["enter"])},null,8,["modelValue","label"])]),_:1},8,["modelValue"])]),_:1}),l(R,null,{default:t(()=>[l(_),l(C,{color:"error",onClick:w},{default:t(()=>[m(f(e.$t("common.cancel")),1)]),_:1}),l(C,{color:"accent",disabled:!d.value,onClick:v},{default:t(()=>[m(f(e.$t("common.save")),1)]),_:1},8,["disabled"])]),_:1})]),_:1})]),_:1},8,["modelValue"]))}})});export{H as _,__tla};