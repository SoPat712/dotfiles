import{u as W,n as J,o as K,L as s,p as Q,q as I,r as X,T as Y,s as g,k as R,t as m,v as Z,w as ee,x as c,a as te,y as A,z as le,A as ae,B as se,j as ne,C as oe,D as re}from"./index-BhWmfNB5.js";import{h as ue,P as ie,Q as de,c as T,d as me,H as ce,R as pe,B as u,N as C,m as e,G as t,S as f,J as i,u as n,O as v,D as y,M as V,F,T as ge,I as B,U as E}from"./vue-DFryKk-1.js";import{u as fe}from"./vuetify-XtA0Y0Oj.js";const ve={class:"pa-3"},ye={style:{"font-size":"1.6em !important"},class:"subtitle-1 ml-2"},Ve={class:"d-flex justify-end"},he={class:"d-flex mr-8 overflow-hidden"},ke={class:"d-flex"},we=ue({__name:"Logs",setup(Le){const P=ie(),{t:U}=W(),{current:O}=fe(),h=J(),{filteredLogs:$,logTypeFilter:r,logMessageFilter:k,paginatedResults:M,currentPage:d,pageCount:p,reverseSort:L}=de(h),j=K(),D=T(()=>({light:{normal:"black",info:"blue",warning:"orange",critical:"red"},dark:{normal:"white",info:"deepskyblue",warning:"darkorange",critical:new Y("darkred").lighten(12).toString()}})),_=me([{title:s[s.NORMAL],value:s.NORMAL},{title:s[s.INFO],value:s.INFO},{title:s[s.WARNING],value:s.WARNING},{title:s[s.CRITICAL],value:s.CRITICAL}]),w=T(()=>r.value.length>0),x=T(()=>r.value.length===_.value.length),S=()=>{P.push({name:"dashboard"})},N=a=>`color: ${D.value[O.value.dark?"dark":"light"][s[a.type].toLowerCase()]}`,z=a=>s[a.type],G=a=>re(a.timestamp*1e3).format(j.dateFormat),q=()=>{x.value?r.value=[]:r.value=_.value.map(a=>a.value)},b=a=>{a.key==="Escape"&&S()};return ce(async()=>{document.addEventListener("keydown",b),await h.cleanAndFetchLogs(),Q(h.updateLogs,15e3)}),pe(()=>{document.removeEventListener("keydown",b)}),(a,o)=>(u(),C("div",ve,[e(I,{"no-gutters":"",align:"center",justify:"center"},{default:t(()=>[e(g,null,{default:t(()=>[f("h1",ye,i(n(U)("logs.title")),1)]),_:1}),e(g,null,{default:t(()=>[f("div",Ve,[e(R,{icon:n(L)?"mdi-sort-descending":"mdi-sort-ascending",variant:"plain",onClick:o[0]||(o[0]=l=>L.value=!n(L))},null,8,["icon"]),e(R,{icon:"mdi-close",variant:"plain",onClick:S})])]),_:1})]),_:1}),e(X,null,{default:t(()=>[e(m,null,{default:t(()=>[e(I,null,{default:t(()=>[e(g,{cols:"6"},{default:t(()=>[e(Z,{modelValue:n(r),"onUpdate:modelValue":o[1]||(o[1]=l=>v(r)?r.value=l:null),items:_.value,label:a.$t("logs.filters.type"),"hide-details":"",multiple:"",chips:""},{"prepend-item":t(()=>[e(m,{title:a.$t("common.selectAll"),onClick:q},{prepend:t(()=>[e(ee,{indeterminate:w.value&&!x.value,"model-value":w.value},null,8,["indeterminate","model-value"])]),_:1},8,["title"]),e(c)]),_:1},8,["modelValue","items","label"])]),_:1}),e(g,{cols:"6"},{default:t(()=>[e(te,{modelValue:n(k),"onUpdate:modelValue":o[2]||(o[2]=l=>v(k)?k.value=l:null),label:a.$t("logs.filters.query"),"hide-details":"",clearable:""},null,8,["modelValue","label"])]),_:1})]),_:1})]),_:1}),e(c,{class:"my-3",thickness:"5"}),n(p)>1?(u(),y(m,{key:0},{default:t(()=>[e(A,{modelValue:n(d),"onUpdate:modelValue":o[3]||(o[3]=l=>v(d)?d.value=l:null),length:n(p),"prev-icon":"mdi-menu-left","next-icon":"mdi-menu-right"},null,8,["modelValue","length"])]),_:1})):V("",!0),e(c),(u(!0),C(F,null,ge(n(M),(l,H)=>(u(),C(F,null,[H>0?(u(),y(c,{key:0})):V("",!0),e(m,{class:"pa-0"},{default:t(()=>[e(le,{class:"p-0"},{default:t(()=>[e(ae,{class:"pa-0"},{default:t(()=>[e(se,{class:"text-no-wrap",style:E(N(l))},{default:t(()=>[f("div",he,"["+i(l.id)+"] "+i(l.message),1),e(ne),f("div",ke,i(G(l)),1)]),_:2},1032,["style"]),e(oe,{class:"wrap-word text-select",style:E(N(l))},{default:t(()=>[B(" ["+i(z(l))+"] "+i(l.message),1)]),_:2},1032,["style"])]),_:2},1024)]),_:2},1024)]),_:2},1024)],64))),256)),n($).length===0?(u(),y(m,{key:1},{default:t(()=>[B(i(a.$t("logs.emptyLogList")),1)]),_:1})):V("",!0),e(c),n(p)>1?(u(),y(m,{key:2},{default:t(()=>[e(A,{modelValue:n(d),"onUpdate:modelValue":o[4]||(o[4]=l=>v(d)?d.value=l:null),length:n(p),"prev-icon":"mdi-menu-left","next-icon":"mdi-menu-right"},null,8,["modelValue","length"])]),_:1})):V("",!0)]),_:1})]))}});export{we as default};
