# Test Express MongoDB - Script PowerShell pour Windows

Write-Host "🚀 Test Express MongoDB uniquement..." -ForegroundColor Yellow

# Attendre que les services démarrent
Write-Host "`n⏳ Attente du démarrage des services..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Test MongoDB
Write-Host "`n📊 Test MongoDB..." -ForegroundColor Yellow
try {
    $tcp = New-Object System.Net.Sockets.TcpClient
    $tcp.Connect("localhost", 27017)
    $tcp.Close()
    Write-Host "✅ MongoDB is UP at localhost:27017" -ForegroundColor Green
} catch {
    Write-Host "❌ MongoDB is DOWN at localhost:27017" -ForegroundColor Red
}

# Test Node.js API
Write-Host "`n🌐 Test Node.js API..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3001" -TimeoutSec 5 -UseBasicParsing
    Write-Host "✅ Node.js API is UP at http://localhost:3001" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js API is DOWN at http://localhost:3001" -ForegroundColor Red
}

# Test Mongo Express
Write-Host "`n🔧 Test Mongo Express..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8082" -TimeoutSec 5 -UseBasicParsing
    Write-Host "✅ Mongo Express is UP at http://localhost:8082" -ForegroundColor Green
} catch {
    Write-Host "❌ Mongo Express is DOWN at http://localhost:8082" -ForegroundColor Red
}

# Test API endpoints
Write-Host "`n🔍 Test des endpoints API..." -ForegroundColor Yellow

# Test GET /posts
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3001/posts" -TimeoutSec 5 -UseBasicParsing
    Write-Host "✅ GET /posts - OK" -ForegroundColor Green
} catch {
    Write-Host "❌ GET /posts - FAILED" -ForegroundColor Red
}

# Test GET /health
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3001/health" -TimeoutSec 5 -UseBasicParsing
    Write-Host "✅ GET /health - OK" -ForegroundColor Green
} catch {
    Write-Host "❌ GET /health - FAILED" -ForegroundColor Red
}

Write-Host "`n🎉 Test Express MongoDB terminé !" -ForegroundColor Green
Write-Host "📝 URLs utiles :" -ForegroundColor Yellow
Write-Host "  - API Node.js: http://localhost:3001" -ForegroundColor White
Write-Host "  - Mongo Express: http://localhost:8082" -ForegroundColor White
Write-Host "  - MongoDB: mongodb://admin:password@localhost:27017/blog_db" -ForegroundColor White 