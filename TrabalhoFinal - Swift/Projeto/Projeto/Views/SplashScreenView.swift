//
//  SplashScreenView.swift
//  Projeto
//
//  Created by Afonso Januario on 08/06/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false // Variável que controla se a janela principal está ativa
    @State private var size = 0.8 // Variável para controlar a escala da animação
    @State private var opacity = 0.5 // Variável para controlar a opacidade da animação
    
    var body: some View {
        ZStack {
            // Fundo preto que preenche toda a área disponível
            Color.black.edgesIgnoringSafeArea(.all)
            
            // Se a janela principal estiver ativa, mostra o ContentView
            if isActive {
                ContentView()
            } else {
                VStack {
                    VStack {
                        // Mostra a imagem da pokebola
                        Image("pokebola")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        // Mostra o texto Pokédex APP
                        Text("Pokédex APP")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                            .foregroundColor(.white.opacity(0.80))
                      
                    }
    
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        // Anima a escala e a opacidade da VStack quando ela aparece
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    // Muda para o ContentView após 2 segundos
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isActive = true
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
