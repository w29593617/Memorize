//
//  ContentView.swift
//  Memorize
//
//  Created by 李昊天 on 2020/5/31.
//  Copyright © 2020 HauTen Lee. All rights reserved.
//
import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture(perform: {
                self.viewModel.choose(card: card)
            })
            .padding(5)
        }
            .padding()
            .foregroundColor(Color.orange)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack { //TODO: - If I use 'return ZStack{} here, displays nothing, why?
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.3)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                }
            .cardify(isFaceUp: card.isFaceUp)
         }
    }
    
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * fontScaleFactor
    }
    // MARK: - Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.75
}

}
