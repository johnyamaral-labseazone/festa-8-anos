# Festa de 8 anos da Seazone — checklist de materiais

Acompanhamento das peças de comunicação e produção da festa de **28/11/2026**.
Mote do ano: **8 anos de evolução. 1 ano de revolução.**

Todas as peças devem estar aprovadas até **31/10** — novembro fica para produção e montagem.

## Como o time acompanha

Abra o link do GitHub Pages do repositório. A página é somente leitura: mostra o
andamento por categoria, o status de cada peça, responsável, prazo e o que já está atrasado.

## Como atualizar (responsável pelo checklist)

1. Abra o `index.html` deste repositório direto do disco (duplo clique).
   Aberto do disco, ele entra em **modo edição**; servido pelo Pages, fica em modo leitura.
2. Altere status, responsável, prazo — ou adicione peças.
   As mudanças ficam salvas no seu navegador enquanto você não publica.
3. Clique em **Salvar alterações**: baixa um `pecas.js` atualizado para a pasta Downloads.
4. Dê duplo clique em **`publicar.cmd`**. Ele acha o arquivo baixado, substitui o `pecas.js`,
   mostra o que mudou, faz o commit e o push.

Se preferir na mão: copie o `pecas.js` baixado por cima do que está na pasta e rode
`git add pecas.js && git commit -m "checklist: atualiza andamento" && git push`.

Cada publicação é um commit, então o histórico do repositório mostra como o checklist evoluiu.

## Arquivos

| Arquivo | O que é |
|---|---|
| `index.html` | a página inteira — estilo, layout e lógica |
| `pecas.js` | os dados do checklist; é o único arquivo que muda no dia a dia |
| `publicar.cmd` | publica a atualização em um clique (chama o `publicar.ps1`) |
