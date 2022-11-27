class Cadastro{

int id_imagem = 0;
int id_descricao = 0;
String _imagem = "";
int _like = 0;
String _descricao = "";

setidImagem(int id_imagem){
  this.id_imagem = id_imagem;
}

getidImagem(){
  return this.id_imagem;
}

setidDescricao(int id_descricao){
  this.id_descricao = id_descricao;
}

getidDescicao(){
  return this.id_descricao;
}

setImagem(String imagem){
  this._imagem = imagem;
}

getImagem(){
  return this._imagem;
}

setLike(int like){
  this._like = like;
}

getLike(){
  return this._like;
}

setDescricao(String descricao){
  this._descricao = descricao;
}

getDescricao(){
  return this._descricao;
}
}