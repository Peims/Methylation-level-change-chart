rm(list=ls())
a<- data.table::fread('DS1.mC_gene_updown_level.txt')
b<- data.table::fread('DS6.mC_gene_updown_level.txt')
c<- data.table::fread('DS8.mC_gene_updown_level.txt')
d<- data.table::fread('DS9.mC_gene_updown_level.txt')
e<- data.table::fread('DS11.mC_gene_updown_level.txt')
names(a)[4]<- "Phase" 
names(b)[4]<- "Phase" 
names(c)[4]<- "Phase" 
names(d)[4]<- "Phase" 
names(e)[4]<- "Phase" 
 
a_CG<- dplyr::filter(a,Phase=='mCG/CG')
a_CHG<- dplyr::filter(a,Phase=='mCHG/CHG')
a_CHH<- dplyr::filter(a,Phase=='mCHH/CHH')

b_CG<- dplyr::filter(b,Phase=='mCG/CG')
b_CHG<- dplyr::filter(b,Phase=='mCHG/CHG')
b_CHH<- dplyr::filter(b,Phase=='mCHH/CHH')

c_CG<- dplyr::filter(c,Phase=='mCG/CG')
c_CHG<- dplyr::filter(c,Phase=='mCHG/CHG')
c_CHH<- dplyr::filter(c,Phase=='mCHH/CHH')

d_CG<- dplyr::filter(d,Phase=='mCG/CG')
d_CHG<- dplyr::filter(d,Phase=='mCHG/CHG')
d_CHH<- dplyr::filter(d,Phase=='mCHH/CHH')

e_CG<- dplyr::filter(e,Phase=='mCG/CG')
e_CHG<- dplyr::filter(e,Phase=='mCHG/CHG')
e_CHH<- dplyr::filter(e,Phase=='mCHH/CHH')

a_CG$Phase<- 'PY1'
a_CHG$Phase<- 'PY1'
a_CHH$Phase<- 'PY1'

b_CG$Phase<- 'PY2'
b_CHG$Phase<- 'PY2'
b_CHH$Phase<- 'PY2'

c_CG$Phase<- 'PY3'
c_CHG$Phase<- 'PY3'
c_CHH$Phase<- 'PY3'

d_CG$Phase<- 'PY4'
d_CHG$Phase<- 'PY4'
d_CHH$Phase<- 'PY4'

e_CG$Phase<- 'PY5'
e_CHG$Phase<- 'PY5'
e_CHH$Phase<- 'PY5'

CG<- rbind(a_CG,b_CG,c_CG,d_CG,e_CG)
CHG<- rbind(a_CHG,b_CHG,c_CHG,d_CHG,e_CHG)
CHH<- rbind(a_CHH,b_CHH,c_CHH,d_CHH,e_CHH)
library(ggplot2)


p1<- ggplot(CG, aes(x=V1, y=V2,color=Phase)) +
  geom_line()+theme_classic()+labs(x=NULL,y='Methylation level')+
  scale_x_continuous(breaks=c(25,75,125),labels=NULL)+
  geom_vline(data=CG, aes(xintercept=c(50)),linetype="dashed")+
  geom_vline(data=CG, aes(xintercept=c(100)),linetype="dashed")+ggtitle('mCG/CG')+
  theme(plot.title = element_text(hjust = 0.5))+theme(legend.position = 'none')

p2<- ggplot(CHG, aes(x=V1, y=V2,color=Phase)) +
  geom_line()+theme_classic()+labs(x=NULL,y='Methylation level')+
  scale_x_continuous(breaks=c(25,75,125),labels=NULL)+
  geom_vline(data=CHG, aes(xintercept=c(50)),linetype="dashed")+
  geom_vline(data=CHG, aes(xintercept=c(100)),linetype="dashed")+ggtitle('mCHG/CHG')+
  theme(plot.title = element_text(hjust = 0.5))+theme(legend.position = 'none')

p3<- ggplot(CHH, aes(x=V1, y=V2,color=Phase)) +
  geom_line()+theme_classic()+labs(x='Region',y='Methylation level')+
  scale_x_continuous(breaks=c(25,75,125),labels=c('promoter(2k)','genebody','downstream(2k)'))+
  geom_vline(data=CHH, aes(xintercept=c(50)),linetype="dashed")+
  geom_vline(data=CHH, aes(xintercept=c(100)),linetype="dashed")+ggtitle('mCHH/CHH')+
  theme(plot.title = element_text(hjust = 0.5))+theme(legend.position = c(0.5,0.5))
require(cowplot)

cowplot::plot_grid(p1,p2,p3,nrow =3)
