##################################
###    TRATAMENTO DOS DADOS    ###
##################################


# BAIXAR PACOTES, CASO ELES AINDA NAO ESTEJAM BAIXADOS
if(!require(dplyr)) install.packages("dplyr")
#if(!require(writexl)) install.packages("writexl")

# CARREGAR PACOTES
library(dplyr)
#library(writexl)

# BUSCAR DIRETÓRIO (PASTA COM OS ARQUIVOS)
setwd("../data")

# ABRIR ARQUIVO
arch_db_orig <- read.csv("Tomada de Decisão Arquitetural V2.csv", sep=",", encoding = "UTF-8")

#RENOMEANDO DAS COLUNAS
cols_renamed <- c(dt_hora = "Carimbo.de.data.hora", 
                  agreement = "Confirme.que.você.concorda.com.os.termos.e.condições.acima.para.a.pesquisa.",
                  age="Qual.sua.idade.",
                  it_years = "Há.quantos.anos.você.trabalha.na.área.de.tecnologia.da.informação.TI.",
                  job_function = "Qual.sua.função.na.empresa.onde.vc.trabalha.",
                  team_size = "Qual.o.tamanho.da.sua.equipe.de.trabalho.",
                  education_level = "Qual.seu.grau.de.educação.formal.",
                  arch_dec_res = "Você.é.responsável.pelas.decisões.arquiteturais.no.seu.local.de.trabalho.",
                  arch_dec_experience = "Há.quantos.anos.você.trabalha.tomando.e.ou.documentando.decisões.arquiteturais.",
                  project_phase = "Em.qual.fase.do.projeto.são.tomadas.as.decisões.arquiteturais.",
                  arch_dec_process = "Como.as.decisões.arquiteturais.são.tomadas.",
                  custom_arch_dec = "Descreva.como.são.tomadas.as.decisões.arquiteturais.onde.você.trabalha.",
                  arch_dec_confidence = "O.quão.confiante.você.é.ao.tomar.uma.decisão.arquitetural.",
                  arch_dec_options = "Ao.tomar.uma.decisão.arquitetural..você.procura.eleger.mais.uma.solução.na.sua.mente.",
                  arch_dec_tools = "Você.utiliza.alguma.ferramenta.de.apoio.a.tomada.de.decisão.arquitetural.",
                  arch_dec_doc = "Como.são.documentadas.as.decisões.arquiteturais.tomadas.",
                  arch_dec_doc_importance = "Quão.importante.você.considera.documentar.decisões.arquiteturais.tomadas.",
                  arch_dec_revisit = "As.decisões.arquiteturais.tomadas.são.revisitadas.durante.o.tempo.de.vida.do.projeto..",
                  factor_size = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Tamanho.da.Empresa.",
                  factor_business = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Fatores.Negociais..Domínio..Modelo..Custo.Risco.Tempo..Estratégia.de.Negócio..",
                  factor_organizational = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Fatores.Organizacionais..Tamanho.do.Time..Organização.do.Time..Processos.e.Práticas..Padrões.e.Restrições..",
                  factor_technical = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Fatores.Técnicos..Princípios.e.Padrões..Restrições..",
                  factor_cultural = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Fatores.Culturais.",
                  factor_individual = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Fatores.Individuais.",
                  factor_project = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Fatores.de.Projeto..Tipo.e.Duração.do.Projeto..",
                  factor_scope = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Escopo.da.Decisão.",
                  factor_quality_attribute = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Atributos.de.Qualidade.",
                  factor_user_requirement = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Requisitos.do.Usuário.",
                  factor_literature = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Literatura.existente.",
                  factor_tools_trend_available = "Indique.o.quão.importante.são.os.fatores.listados.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Ferramentas.e.Tecnologia.Disponíveis.",
                  lack_req_clarity = "Indique.o.quão.impactante.são.as.dificuldades.listadas.durante.o.processo.de.tomada.de.decisão.arquitetural...Falta.de.clareza.nos.requisitos.",
                  non_req_conflict = "Indique.o.quão.impactante.são.as.dificuldades.listadas.durante.o.processo.de.tomada.de.decisão.arquitetural...Requisitos.Não.Funcionais.Conflitantes..ex...Desempenho.x.Segurança..",
                  insufficient_deadline = "Indique.o.quão.impactante.são.as.dificuldades.listadas.durante.o.processo.de.tomada.de.decisão.arquitetural...Prazo.de.entrega.insuficiente.",
                  stakeholder_conflict = "Indique.o.quão.impactante.são.as.dificuldades.listadas.durante.o.processo.de.tomada.de.decisão.arquitetural...Conflito.entre.Stakeholders.",
                  contractual_obligation = "Indique.o.quão.impactante.são.as.dificuldades.listadas.durante.o.processo.de.tomada.de.decisão.arquitetural...Obrigações.Contratuais.Legais..ex...LGPD..",
                  business_domain_lack = "Indique.o.quão.impactante.são.as.dificuldades.listadas.durante.o.processo.de.tomada.de.decisão.arquitetural...Pouca.Familiariadade.com.Domínio.de.Negócio.",
                  principle_facts = "Indique.o.quão.importante.são.os.princípios.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Utilizar.fatos.ao.invés.de.suposições.",
                  principle_solution = "Indique.o.quão.importante.são.os.princípios.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Verificar.adequação.da.solução.com.o.problema.",
                  principle_pros_cons = "Indique.o.quão.importante.são.os.princípios.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Checar.prós.e.contras.da.solução.selecionada.",
                  principle_solution_limitation = "Indique.o.quão.importante.são.os.princípios.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Escolher.a.solução.de.acordo.com.as.limitações.do.sistema.",
                  principle_arch_solution = "Indique.o.quão.importante.são.os.princípios.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Pensar.em.mais.de.uma.solução.arquitetural.para.o.problema.",
                  principle_timeframe = "Indique.o.quão.importante.são.os.princípios.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Decidir.respeitando.o.tempo.de.entrega.do.sistema.",
                  principle_priority = "Indique.o.quão.importante.são.os.princípios.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Definir.prioridades.do.sistema.",
                  principle_risks = "Indique.o.quão.importante.são.os.princípios.abaixo.para.o.processo.de.tomada.de.decisão.arquitetural...Antecipar.possíveis.riscos.na.escolha.da.solução."
)
arch_db_filtered <- rename(arch_db_orig, all_of(cols_renamed))

#FILTRANDO AS LINHAS CUJO RESPONDENTE NAO TEM RESPONSABILIDADE ARQUITETURAL
arch_db_filtered <- arch_db_filtered %>% filter(arch_dec_res=="Sim")

#REMOVENDO COLUNAS DATA/HORA, CONCORDO E ARQ
arch_db_filtered <- subset(arch_db_filtered, select = -c(dt_hora, agreement, arch_dec_res))

# table(arch_db_filtered$project_phase) 

#CONVERTENDO COLUNA age
arch_db_filtered$age[arch_db_filtered$age == "Mais de 50 anos"] <- "More than 50 years"
arch_db_filtered$age[arch_db_filtered$age == "41 a 50 anos"] <- "41 to 50 years"
arch_db_filtered$age[arch_db_filtered$age == "31 a 40 anos"] <- "31 to 40 years"
arch_db_filtered$age[arch_db_filtered$age == "20 a 30 anos"] <- "20 to 30 years"

#CONVERTENDO COLUNA team_size
arch_db_filtered$team_size[arch_db_filtered$team_size == "Mais de 100"] <- "100+"

#CORRIGINDO ERRO DE DIGITACAO
arch_db_filtered[arch_db_filtered == "Moderamente Importante"] <- "Moderadamente Importante"

#CONVERTENDO COLUMN job_function
arch_db_filtered$job_function[arch_db_filtered$job_function == "Gerente de Projeto"] <- "Project Manager"
arch_db_filtered$job_function[arch_db_filtered$job_function == "Consultor"] <- "Consultant"
arch_db_filtered$job_function[arch_db_filtered$job_function == "Líder de time"] <- "Team Lead"
arch_db_filtered$job_function[arch_db_filtered$job_function == "Desenvolvedor(a) Senior"] <- "Senior Developer"
arch_db_filtered$job_function[arch_db_filtered$job_function == "Desenvolvedor Pleno"] <- "Other"
arch_db_filtered$job_function[arch_db_filtered$job_function == "Engenheiro(a) de Software"] <- "Software Engineer"
arch_db_filtered$job_function[arch_db_filtered$job_function == "Arquiteto(a) de Software"] <- "Architect"
arch_db_filtered$job_function[arch_db_filtered$job_function == "Analista de Negócios"] <- "Other"
arch_db_filtered$job_function[arch_db_filtered$job_function == "Diretor de sistemas"] <- "Other"
arch_db_filtered$job_function[trimws(arch_db_filtered$job_function) == "Gerente de Operações"] <- "Other"

#CONVERTING COLUMN EDUCATION_LEVEL
arch_db_filtered$education_level[arch_db_filtered$education_level == "Estudante de Graduação"] <- "Undergraduated"
arch_db_filtered$education_level[arch_db_filtered$education_level == "Graduação"] <- "Graduated"
arch_db_filtered$education_level[arch_db_filtered$education_level == "Pós-Graduação / MBA"] <- "MBA"
arch_db_filtered$education_level[arch_db_filtered$education_level == "Mestrado"] <- "Master's Degree"
arch_db_filtered$education_level[arch_db_filtered$education_level == "Doutorado / PhD"] <- "PHD"

#CONVERTING COLUMN IT_YEARS
arch_db_filtered$it_years[arch_db_filtered$it_years == ""] <- "1 to 5 years"
arch_db_filtered$it_years[arch_db_filtered$it_years == "1 a 5 anos"] <- "1 to 5 years"
arch_db_filtered$it_years[arch_db_filtered$it_years == "6 a 10 anos"] <- "6 to 10 years"
arch_db_filtered$it_years[arch_db_filtered$it_years == "11 a 15 anos"] <- "11 to 15 years"
arch_db_filtered$it_years[arch_db_filtered$it_years == "Mais de 15 anos"] <- "More than 15"

#CONVERTING COLUMN ARCH_DEC_EXPERIENCE
arch_db_filtered$arch_dec_experience[arch_db_filtered$arch_dec_experience == "Mais de 20 anos"] <- "More than 20 years"
arch_db_filtered$arch_dec_experience[arch_db_filtered$arch_dec_experience == "10 a 20 anos"] <- "10 to 20 years"
arch_db_filtered$arch_dec_experience[arch_db_filtered$arch_dec_experience == "5 a 10 anos"] <- "5 to 10 years"
arch_db_filtered$arch_dec_experience[arch_db_filtered$arch_dec_experience == "3 a 4 anos"] <- "3 to 4 years"
arch_db_filtered$arch_dec_experience[arch_db_filtered$arch_dec_experience == "1 a 2 anos"] <- "1 to 2 years"

#CONVERTING COLUMN PROJECT_PHASE
arch_db_filtered$project_phase[arch_db_filtered$project_phase == "Qualquer momento"] <- "No specific point"
arch_db_filtered$project_phase[arch_db_filtered$project_phase == "Fase inicial do projeto"] <- "At the beginning of project"
arch_db_filtered$project_phase[arch_db_filtered$project_phase == "Durante as iterações ou sprints"] <- "At each sprint/iteration"
arch_db_filtered$project_phase[arch_db_filtered$project_phase == "Não existe uma fase definida, tomamos decisões a medida que os desafios são impostos."] <- "Other"
arch_db_filtered$project_phase[arch_db_filtered$project_phase == "As decisões arquiteturais geralmente são tomadas na fase inicial do projeto, mas também podem ser revistas e ajustadas durante as iterações ou sprints conforme necessário."] <- "Other"
arch_db_filtered$project_phase[arch_db_filtered$project_phase == "Refinamento tecnico"] <- "Other"


#CONVERTING COLUMN ARCH_DEC_PROCESS
arch_db_filtered$arch_dec_process[arch_db_filtered$arch_dec_process == "Decisão em grupo"] <- "Group decision"
arch_db_filtered$arch_dec_process[arch_db_filtered$arch_dec_process == "Individualmente"] <- "Individual decision"
arch_db_filtered$arch_dec_process[arch_db_filtered$arch_dec_process == "Depende do projeto, mas normalmente em grupo."] <- "Group decision"

#CONVERTING COLUMN FACTOR_SIZE
arch_db_filtered$factor_size[arch_db_filtered$factor_size == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_size[arch_db_filtered$factor_size == "Muito Importante"] <- "Important"
arch_db_filtered$factor_size[arch_db_filtered$factor_size == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_size[arch_db_filtered$factor_size == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_size[arch_db_filtered$factor_size == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_size[arch_db_filtered$factor_size == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_BUSINESS
arch_db_filtered$factor_business[arch_db_filtered$factor_business == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_business[arch_db_filtered$factor_business == "Muito Importante"] <- "Important"
arch_db_filtered$factor_business[arch_db_filtered$factor_business == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_business[arch_db_filtered$factor_business == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_business[arch_db_filtered$factor_business == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_business[arch_db_filtered$factor_business == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_ORGANIZATIONAL
arch_db_filtered$factor_organizational[arch_db_filtered$factor_organizational == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_organizational[arch_db_filtered$factor_organizational == "Muito Importante"] <- "Important"
arch_db_filtered$factor_organizational[arch_db_filtered$factor_organizational == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_organizational[arch_db_filtered$factor_organizational == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_organizational[arch_db_filtered$factor_organizational == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_organizational[arch_db_filtered$factor_organizational == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_TECHNICAL
arch_db_filtered$factor_technical[arch_db_filtered$factor_technical == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_technical[arch_db_filtered$factor_technical == "Muito Importante"] <- "Important"
arch_db_filtered$factor_technical[arch_db_filtered$factor_technical == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_technical[arch_db_filtered$factor_technical == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_technical[arch_db_filtered$factor_technical == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_technical[arch_db_filtered$factor_technical == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_INDIVIDUAL
arch_db_filtered$factor_individual[arch_db_filtered$factor_individual == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_individual[arch_db_filtered$factor_individual == "Muito Importante"] <- "Important"
arch_db_filtered$factor_individual[arch_db_filtered$factor_individual == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_individual[arch_db_filtered$factor_individual == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_individual[arch_db_filtered$factor_individual == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_individual[arch_db_filtered$factor_individual == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_CULTURAL
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Muito Importante"] <- "Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_CULTURAL
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Muito Importante"] <- "Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_cultural[arch_db_filtered$factor_cultural == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_PROJECT
arch_db_filtered$factor_project[arch_db_filtered$factor_project == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_project[arch_db_filtered$factor_project == "Muito Importante"] <- "Important"
arch_db_filtered$factor_project[arch_db_filtered$factor_project == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_project[arch_db_filtered$factor_project == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_project[arch_db_filtered$factor_project == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_project[arch_db_filtered$factor_project == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_SCOPE
arch_db_filtered$factor_scope[arch_db_filtered$factor_scope == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_scope[arch_db_filtered$factor_scope == "Muito Importante"] <- "Important"
arch_db_filtered$factor_scope[arch_db_filtered$factor_scope == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_scope[arch_db_filtered$factor_scope == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_scope[arch_db_filtered$factor_scope == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_scope[arch_db_filtered$factor_scope == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_QUALITY
arch_db_filtered$factor_quality_attribute[arch_db_filtered$factor_quality_attribute == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_quality_attribute[arch_db_filtered$factor_quality_attribute == "Muito Importante"] <- "Important"
arch_db_filtered$factor_quality_attribute[arch_db_filtered$factor_quality_attribute == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_quality_attribute[arch_db_filtered$factor_quality_attribute == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_quality_attribute[arch_db_filtered$factor_quality_attribute == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_quality_attribute[arch_db_filtered$factor_quality_attribute == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_USER_REQ
arch_db_filtered$factor_user_requirement[arch_db_filtered$factor_user_requirement == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_user_requirement[arch_db_filtered$factor_user_requirement == "Muito Importante"] <- "Important"
arch_db_filtered$factor_user_requirement[arch_db_filtered$factor_user_requirement == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_user_requirement[arch_db_filtered$factor_user_requirement == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_user_requirement[arch_db_filtered$factor_user_requirement == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_user_requirement[arch_db_filtered$factor_user_requirement == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_LITERATURE
arch_db_filtered$factor_literature[arch_db_filtered$factor_literature == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_literature[arch_db_filtered$factor_literature == "Muito Importante"] <- "Important"
arch_db_filtered$factor_literature[arch_db_filtered$factor_literature == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_literature[arch_db_filtered$factor_literature == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_literature[arch_db_filtered$factor_literature == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_literature[arch_db_filtered$factor_literature == "Não se aplica"] <- "NA"

#CONVERTING COLUMN FACTOR_TOOLS_TREND
arch_db_filtered$factor_tools_trend_available[arch_db_filtered$factor_tools_trend_available == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$factor_tools_trend_available[arch_db_filtered$factor_tools_trend_available == "Muito Importante"] <- "Important"
arch_db_filtered$factor_tools_trend_available[arch_db_filtered$factor_tools_trend_available == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$factor_tools_trend_available[arch_db_filtered$factor_tools_trend_available == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$factor_tools_trend_available[arch_db_filtered$factor_tools_trend_available == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$factor_tools_trend_available[arch_db_filtered$factor_tools_trend_available == "Não se aplica"] <- "NA"

#CONVERTING COLUMN ARCH_DEC_TOOLS
arch_db_filtered$arch_dec_tools[arch_db_filtered$arch_dec_tools == "Não"] <- "No"
arch_db_filtered$arch_dec_tools[arch_db_filtered$arch_dec_tools == "Sim"] <- "Yes"

#CONVERTING COLUMN LACK_REQ_CLARITY
arch_db_filtered$lack_req_clarity[arch_db_filtered$lack_req_clarity == "Impacto muito elevado"] <- "Very high"
arch_db_filtered$lack_req_clarity[arch_db_filtered$lack_req_clarity == "Impacto elevado"] <- "Above average"
arch_db_filtered$lack_req_clarity[arch_db_filtered$lack_req_clarity == "Impacto moderado"] <- "Average"
arch_db_filtered$lack_req_clarity[arch_db_filtered$lack_req_clarity == "Pouco impacto"] <- "Below Average"
arch_db_filtered$lack_req_clarity[arch_db_filtered$lack_req_clarity == "Nenhum impacto"] <- "Very low"
arch_db_filtered$lack_req_clarity[arch_db_filtered$lack_req_clarity == "Não se aplica"] <- "NA"


#CONVERTING COLUMN NFR_CONFLICT
arch_db_filtered$non_req_conflict[arch_db_filtered$non_req_conflict == "Impacto muito elevado"] <- "Very high"
arch_db_filtered$non_req_conflict[arch_db_filtered$non_req_conflict == "Impacto elevado"] <- "Above average"
arch_db_filtered$non_req_conflict[arch_db_filtered$non_req_conflict == "Impacto moderado"] <- "Average"
arch_db_filtered$non_req_conflict[arch_db_filtered$non_req_conflict == "Pouco impacto"] <- "Below Average"
arch_db_filtered$non_req_conflict[arch_db_filtered$non_req_conflict == "Nenhum impacto"] <- "Very low"
arch_db_filtered$non_req_conflict[arch_db_filtered$non_req_conflict == "Não se aplica"] <- "NA"


#CONVERTING COLUMN INSUFFICIENTE_DEADLINE
arch_db_filtered$insufficient_deadline[arch_db_filtered$insufficient_deadline == "Impacto muito elevado"] <- "Very high"
arch_db_filtered$insufficient_deadline[arch_db_filtered$insufficient_deadline == "Impacto elevado"] <- "Above average"
arch_db_filtered$insufficient_deadline[arch_db_filtered$insufficient_deadline == "Impacto moderado"] <- "Average"
arch_db_filtered$insufficient_deadline[arch_db_filtered$insufficient_deadline == "Pouco impacto"] <- "Below Average"
arch_db_filtered$insufficient_deadline[arch_db_filtered$insufficient_deadline == "Nenhum impacto"] <- "Very low"
arch_db_filtered$insufficient_deadline[arch_db_filtered$insufficient_deadline == "Não se aplica"] <- "NA"


#CONVERTING COLUMN INSUFFICIENTE_DEADLINE
arch_db_filtered$stakeholder_conflict[arch_db_filtered$stakeholder_conflict == "Impacto muito elevado"] <- "Very high"
arch_db_filtered$stakeholder_conflict[arch_db_filtered$stakeholder_conflict == "Impacto elevado"] <- "Above average"
arch_db_filtered$stakeholder_conflict[arch_db_filtered$stakeholder_conflict == "Impacto moderado"] <- "Average"
arch_db_filtered$stakeholder_conflict[arch_db_filtered$stakeholder_conflict == "Pouco impacto"] <- "Below Average"
arch_db_filtered$stakeholder_conflict[arch_db_filtered$stakeholder_conflict == "Nenhum impacto"] <- "Very low"
arch_db_filtered$stakeholder_conflict[arch_db_filtered$stakeholder_conflict == "Não se aplica"] <- "NA"


#CONVERTING COLUMN CONTRACTUAL_OBLIGATION
arch_db_filtered$contractual_obligation[arch_db_filtered$contractual_obligation == "Impacto muito elevado"] <- "Very high"
arch_db_filtered$contractual_obligation[arch_db_filtered$contractual_obligation == "Impacto elevado"] <- "Above average"
arch_db_filtered$contractual_obligation[arch_db_filtered$contractual_obligation == "Impacto moderado"] <- "Average"
arch_db_filtered$contractual_obligation[arch_db_filtered$contractual_obligation == "Pouco impacto"] <- "Below Average"
arch_db_filtered$contractual_obligation[arch_db_filtered$contractual_obligation == "Nenhum impacto"] <- "Very low"
arch_db_filtered$contractual_obligation[arch_db_filtered$contractual_obligation == "Não se aplica"] <- "NA"


#CONVERTING COLUMN BUSINESS_DOMAIN_LACK
arch_db_filtered$business_domain_lack[arch_db_filtered$business_domain_lack == "Impacto muito elevado"] <- "Very high"
arch_db_filtered$business_domain_lack[arch_db_filtered$business_domain_lack == "Impacto elevado"] <- "Above average"
arch_db_filtered$business_domain_lack[arch_db_filtered$business_domain_lack == "Impacto moderado"] <- "Average"
arch_db_filtered$business_domain_lack[arch_db_filtered$business_domain_lack == "Pouco impacto"] <- "Below Average"
arch_db_filtered$business_domain_lack[arch_db_filtered$business_domain_lack == "Nenhum impacto"] <- "Very low"
arch_db_filtered$business_domain_lack[arch_db_filtered$business_domain_lack == "Não se aplica"] <- "NA"


#CONVERTING COLUMN PRINCIPLE_FACTS
arch_db_filtered$principle_facts[arch_db_filtered$principle_facts == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$principle_facts[arch_db_filtered$principle_facts == "Muito Importante"] <- "Important"
arch_db_filtered$principle_facts[arch_db_filtered$principle_facts == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$principle_facts[arch_db_filtered$principle_facts == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$principle_facts[arch_db_filtered$principle_facts == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$principle_facts[arch_db_filtered$principle_facts == "Não se aplica"] <- "NA"


#CONVERTING COLUMN PRINCIPLE_SOLUTION
arch_db_filtered$principle_solution[arch_db_filtered$principle_solution == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$principle_solution[arch_db_filtered$principle_solution == "Muito Importante"] <- "Important"
arch_db_filtered$principle_solution[arch_db_filtered$principle_solution == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$principle_solution[arch_db_filtered$principle_solution == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$principle_solution[arch_db_filtered$principle_solution == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$principle_solution[arch_db_filtered$principle_solution == "Não se aplica"] <- "NA"


#CONVERTING COLUMN PRINCIPLE_PROS_CONS
arch_db_filtered$principle_pros_cons[arch_db_filtered$principle_pros_cons == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$principle_pros_cons[arch_db_filtered$principle_pros_cons == "Muito Importante"] <- "Important"
arch_db_filtered$principle_pros_cons[arch_db_filtered$principle_pros_cons == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$principle_pros_cons[arch_db_filtered$principle_pros_cons == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$principle_pros_cons[arch_db_filtered$principle_pros_cons == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$principle_pros_cons[arch_db_filtered$principle_pros_cons == "Não se aplica"] <- "NA"


#CONVERTING COLUMN PRINCIPLE_SOLUTION_LIMITATION
arch_db_filtered$principle_solution_limitation[arch_db_filtered$principle_solution_limitation == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$principle_solution_limitation[arch_db_filtered$principle_solution_limitation == "Muito Importante"] <- "Important"
arch_db_filtered$principle_solution_limitation[arch_db_filtered$principle_solution_limitation == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$principle_solution_limitation[arch_db_filtered$principle_solution_limitation == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$principle_solution_limitation[arch_db_filtered$principle_solution_limitation == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$principle_solution_limitation[arch_db_filtered$principle_solution_limitation == "Não se aplica"] <- "NA"


#CONVERTING COLUMN PRINCIPLE_ARCH_SOLUTION
arch_db_filtered$principle_arch_solution[arch_db_filtered$principle_arch_solution == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$principle_arch_solution[arch_db_filtered$principle_arch_solution == "Muito Importante"] <- "Important"
arch_db_filtered$principle_arch_solution[arch_db_filtered$principle_arch_solution == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$principle_arch_solution[arch_db_filtered$principle_arch_solution == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$principle_arch_solution[arch_db_filtered$principle_arch_solution == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$principle_arch_solution[arch_db_filtered$principle_arch_solution == "Não se aplica"] <- "NA"


#CONVERTING COLUMN PRINCIPLE_TIMEFRAME
arch_db_filtered$principle_timeframe[arch_db_filtered$principle_timeframe == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$principle_timeframe[arch_db_filtered$principle_timeframe == "Muito Importante"] <- "Important"
arch_db_filtered$principle_timeframe[arch_db_filtered$principle_timeframe == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$principle_timeframe[arch_db_filtered$principle_timeframe == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$principle_timeframe[arch_db_filtered$principle_timeframe == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$principle_timeframe[arch_db_filtered$principle_timeframe == "Não se aplica"] <- "NA"


#CONVERTING COLUMN PRINCIPLE_PRIORITY
arch_db_filtered$principle_priority[arch_db_filtered$principle_priority == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$principle_priority[arch_db_filtered$principle_priority == "Muito Importante"] <- "Important"
arch_db_filtered$principle_priority[arch_db_filtered$principle_priority == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$principle_priority[arch_db_filtered$principle_priority == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$principle_priority[arch_db_filtered$principle_priority == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$principle_priority[arch_db_filtered$principle_priority == "Não se aplica"] <- "NA"


#CONVERTING COLUMN PRINCIPLE_RISKS
arch_db_filtered$principle_risks[arch_db_filtered$principle_risks == "Extremamente Importante"] <- "Very Important"
arch_db_filtered$principle_risks[arch_db_filtered$principle_risks == "Muito Importante"] <- "Important"
arch_db_filtered$principle_risks[arch_db_filtered$principle_risks == "Moderadamente Importante"] <- "Moderately Important"
arch_db_filtered$principle_risks[arch_db_filtered$principle_risks == "Pouco Importante"] <- "Slightly Important"
arch_db_filtered$principle_risks[arch_db_filtered$principle_risks == "Nenhum Pouco Importante"] <- "Not Important"
arch_db_filtered$principle_risks[arch_db_filtered$principle_risks == "Não se aplica"] <- "NA"


#CONVERSAO DAS COLUNAS PARA FACTOR
arch_db_filtered$age <- as.factor(arch_db_filtered$age)
arch_db_filtered$it_years <- as.factor(arch_db_filtered$it_years)
arch_db_filtered$education_level <- as.factor(arch_db_filtered$education_level)
arch_db_filtered$job_function <- as.factor(arch_db_filtered$job_function)
arch_db_filtered$team_size <- as.factor(arch_db_filtered$team_size)
arch_db_filtered$project_phase <- as.factor(arch_db_filtered$project_phase)
arch_db_filtered$arch_dec_process <- as.factor(arch_db_filtered$arch_dec_process)
arch_db_filtered$arch_dec_confidence <- as.factor(arch_db_filtered$arch_dec_confidence)
arch_db_filtered$factor_size <- as.factor(arch_db_filtered$factor_size)
arch_db_filtered$factor_business <- as.factor(arch_db_filtered$factor_business)
arch_db_filtered$factor_organizational <- as.factor(arch_db_filtered$factor_organizational)
arch_db_filtered$factor_technical <- as.factor(arch_db_filtered$factor_technical)
arch_db_filtered$factor_cultural <- as.factor(arch_db_filtered$factor_cultural)
arch_db_filtered$factor_individual <- as.factor(arch_db_filtered$factor_individual)
arch_db_filtered$factor_project <- as.factor(arch_db_filtered$factor_project)
arch_db_filtered$factor_scope <- as.factor(arch_db_filtered$factor_scope)
arch_db_filtered$factor_quality_attribute <- as.factor(arch_db_filtered$factor_quality_attribute)
arch_db_filtered$factor_user_requirement <- as.factor(arch_db_filtered$factor_user_requirement)
arch_db_filtered$factor_literature <- as.factor(arch_db_filtered$factor_literature)
arch_db_filtered$factor_tools_trend_available <- as.factor(arch_db_filtered$factor_tools_trend_available)
arch_db_filtered$arch_dec_tools <- as.factor(arch_db_filtered$arch_dec_tools)
arch_db_filtered$lack_req_clarity <- as.factor(arch_db_filtered$lack_req_clarity)
arch_db_filtered$non_req_conflict <- as.factor(arch_db_filtered$non_req_conflict)
arch_db_filtered$insufficient_deadline <- as.factor(arch_db_filtered$insufficient_deadline)
arch_db_filtered$stakeholder_conflict <- as.factor(arch_db_filtered$stakeholder_conflict)
arch_db_filtered$contractual_obligation <- as.factor(arch_db_filtered$contractual_obligation)
arch_db_filtered$business_domain_lack <- as.factor(arch_db_filtered$business_domain_lack)
arch_db_filtered$principle_facts <- as.factor(arch_db_filtered$principle_facts)
arch_db_filtered$principle_pros_cons <- as.factor(arch_db_filtered$principle_pros_cons)
arch_db_filtered$principle_solution <- as.factor(arch_db_filtered$principle_solution)
arch_db_filtered$principle_solution_limitation <- as.factor(arch_db_filtered$principle_solution_limitation)
arch_db_filtered$principle_arch_solution <- as.factor(arch_db_filtered$principle_arch_solution)
arch_db_filtered$principle_timeframe <- as.factor(arch_db_filtered$principle_timeframe)
arch_db_filtered$principle_priority <- as.factor(arch_db_filtered$principle_priority)
arch_db_filtered$principle_risks <- as.factor(arch_db_filtered$principle_risks)

summary(arch_db_filtered)

write.table(arch_db_filtered, file = "architectural_decision_survey.csv", sep = ",")
#write_xlsx(arch_db_filtered, "architectural_decision_survey.xlsx")

