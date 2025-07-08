db = db.getSiblingDB('blog_db');
db.posts.insertOne({
  title: "post de test",
  content: "Ceci est un post créé automatiquement pour le test",
  author: "Sinclair BALIVET",
  createdAt: new Date()
}); 