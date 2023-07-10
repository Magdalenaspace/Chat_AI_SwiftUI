//
//  MainView.swift
//  ChatAI
//
//  Created by Magdalena Samuel on 6/27/23.
//

import SwiftUI
import OpenAISwift

struct MainView: View {
    
    
    @State private var chatText: String = ""
    let openAI = OpenAISwift(authToken: "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")
    @EnvironmentObject private var model: Model
    
    //    @State private var answers: [String] = []
    
    @State private var isSearching: Bool = false
    
    private var isFormValid: Bool {
        !chatText.hasWhiteSpacesOrIsEmpt
    }
    
    private func performSearch() {
        openAI.sendCompletion(with: chatText, maxTokens: 500) { result in
            switch result {
            case .success(let success):
                let answer = success.choices?.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                print(answer)
                
                let chat = Chat(question: chatText, answer: answer)
                DispatchQueue.main.async {
                    model.queries.append(chat)
                }
                
                do {
                    try model.saveChat(chat)
                    
                } catch {
                    print(error.localizedDescription)
                }
                chatText = ""
                isSearching = false
            case .failure(let failure):
                isSearching = false
                print(failure)
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                if !model.queries.isEmpty { // Render the list only if answers are available
                    ScrollView {
                        
                        ScrollViewReader { proxy in
                            ForEach(model.queries) { chat in
                                VStack(alignment: .leading) {
                                    Text(chat.question)
                                        .fontWeight(.bold)
                                        .padding()
                                    Text(chat.answer)
                                        .fontWeight(.bold)
                                        .background(Color.white.opacity(0.2))
                                    
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.bottom], 10)
                                    .id(chat.id)
                                    .listRowSeparator(.hidden)
                            }.listStyle(.plain)
                                .onChange(of: model.queries) { query in
                                    if !model.queries.isEmpty {
                                        let lastQuery = model.queries[model.queries.endIndex - 1]
                                        withAnimation {
                                            proxy.scrollTo(lastQuery.id)
                                        }
                                    }
                                }
                        }
                        .foregroundColor(.black)
                    }.padding(.top, 40)
                }
                
                
                Spacer()
                HStack {
                    TextField("Search...", text: $chatText)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .background(Color.gray.opacity(0.4))
                    Button {
                        isSearching = true
                        performSearch()
                    } label: {
                        Image(systemName: "paperplane.circle.fill")
                            .font(.title)
                            .rotationEffect(Angle(degrees: 45))
                    }.buttonStyle(.borderless)
                        .tint(.white)
                        .disabled(!isFormValid)
                    
                }
            }.padding(35)
                .onChange(of: model.query) { query in
                    model.queries.append(query)
                }
                .overlay(alignment: .center) {
                    if isSearching {
                        ProgressView("Searching...")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
//                            .background(Color.white.opacity(0.1))
                            
                    }
                
                }
                .background(
                    GeometryReader { geometry in
                        Image("background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
//                            .overlay(Color.gray.opacity(0.1))
                            .edgesIgnoringSafeArea(.all)
                    }
                )
                .ignoresSafeArea()
        }
    }
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
                .environmentObject(Model())
        }
    }
}
