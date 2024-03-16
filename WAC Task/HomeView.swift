//
//  HomeView.swift
//  WAC Task
//
//  Created by MUNAVAR PM on 15/03/24.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @FetchRequest (sortDescriptors: []) var productsEntity: FetchedResults <ProductEntity>
    @FetchRequest (sortDescriptors: []) var categoriesEntity: FetchedResults <CategoryEntity>
    @Environment(\.managedObjectContext) var moc
    @StateObject var viewModel = TodoViewModel()
    @State private var currentPage = 0
    var body: some View {
        VStack {
            HStack {
                NavBar()
            }
            .padding()
            .background(Color("LGreen"))
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                TabView(selection: $currentPage) {
                    let banners = viewModel.banners
                    ForEach(banners.indices, id: \.self){ index in
                        HStack {
                            if let url = URL(string: banners[index].image_url) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: UIScreen.main.bounds.width, height: 400)
                                }
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(width: UIScreen.main.bounds.width - 16, height: 140)
                
                HStack {
                    Text("Most Popular")
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("View All")
                            .foregroundStyle(.black)
                    }
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.products) { product in
                            ProductView(
                                name: product.content.product_name ?? "Product Name Nil",
                                imageURL: product.content.product_image ?? "Image URL Nil",
                                offer: product.content.discount ?? "Discount Nil",
                                item: product.content.sku ?? "Nil",
                                productRating: product.content.product_rating ?? 0,
                                ActualPrize: product.content.actual_price ?? "0",
                                offerPrize: product.content.offer_price ?? "0"
                            )
                        }

                    }
                    .padding(.leading)
                }
                .padding(.bottom)
                HStack {
                    VStack {
                        if let url = URL(string: viewModel.singleBanner?.image_url ?? "Image Nil") {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                ProgressView()
                                    .frame(width: UIScreen.main.bounds.width, height: 400)
                            }
                        }
                    }
                    .cornerRadius(30)
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 150)
                .background(RoundedRectangle(cornerRadius: 30).stroke(Color.black.opacity(0.4)))
                
                HStack {
                    Text("Catagories")
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("View All")
                            .foregroundStyle(.black)
                    }
                }
                .padding()
                
                let categories = viewModel.categories
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(categories){ item in
                            VStack {
                                VStack {
                                    if let url = URL(string: item.image_url) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: UIScreen.main.bounds.width, height: 100)
                                        }
                                    }
                                }
                                .frame(width: 60, height: 60)
                                Text(item.title)
                                    .font(.system(size: 12))
                            }
                            .frame(width: 110, height: 110)
                            .background(RoundedRectangle(cornerRadius: 30).stroke(Color.black.opacity(0.4)))
                        }
                    }
                    .padding(.leading)
                }
                HStack {
                    Text("Featured Producrts")
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("View All")
                            .foregroundStyle(.black)
                    }
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.products) { product in
                            ProductView(
                                name: product.content.product_name ?? "Product Name Nil",
                                imageURL: product.content.product_image ?? "Image URL Nil",
                                offer: product.content.discount ?? "Discount Nil",
                                item: product.content.sku ?? "Nil",
                                productRating: product.content.product_rating ?? 0,
                                ActualPrize: product.content.actual_price ?? "0",
                                offerPrize: product.content.offer_price ?? "0"
                            )
                        }
                    }
                    .padding(.leading)
                }
                .padding(.bottom, 50)
            }
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                for product in viewModel.products {
                    let productsEntity = ProductEntity(context: self.moc)
                    productsEntity.id = UUID()
                    productsEntity.name = product.content.product_name
                    try? moc.save()
                }
                for category in viewModel.categories {
                    let categoryEntity = CategoryEntity(context: self.moc)
                    categoryEntity.id = UUID()
                    categoryEntity.title = category.title
                    try? moc.save()
                }
            })
        }
    }
}

#Preview {
    HomeView()
}
struct NavBar: View {
    @State private var search: String = ""
    var body: some View {
        HStack(spacing: 20) {
            Button {} label: {
                Image("CartLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 26)
            }
            HStack(spacing: 12) {
                TextField("", text: $search)
                    .autocapitalization(.none)
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 15, weight: .bold)).opacity(0.2)
                    .padding()
            }
            .frame(width: 260, height: 35)
            .background(Color(.white))
            .clipShape(Capsule())
            .shadow(radius: 5, y: 5)
            NotificationBT(numberOfProduct: 0, action: {})
        }
        .padding(.horizontal, 10)
    }
}
struct NotificationBT: View {
    var numberOfProduct: Int
    var action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Image(systemName: "bell")
                    .foregroundStyle(Color(.white))
                if numberOfProduct >= 0 {
                    Text("\(numberOfProduct)")
                        .font(.caption2)
                        .foregroundStyle(Color.white).bold()
                        .frame(width: 15, height: 15)
                        .background(Color.red)
                        .cornerRadius(50)
                        .offset(x: 5, y: -9)
                }
            }
        }
    }
}


struct ProductView: View {
    
    var name: String
    var imageURL: String
    var offer: String
    var item: String
    var productRating: Int
    var ActualPrize: String
    var offerPrize: String
    
    var body: some View {
        
        VStack(spacing: 0) {
            VStack {
                VStack {
                    if let url = URL(string: imageURL) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                                .frame(width: UIScreen.main.bounds.width, height: 400)
                        }
                    }
                }
                .frame(width: 130, height: 150)
                .padding(.horizontal, 2)
            }
            .frame(width: 200, height: 150)
            HStack {
                Text("\(offer > "\(0)" ? "\(offer)" : "\(0)")")
                    .frame(height: 30)
                    .padding(2)
                    .padding(.horizontal, 12)
                    .foregroundStyle(Color(.black))
                    .background(Color("BTOrange"))
                    .cornerRadius(15)
                    .padding(.horizontal, 2)
                Spacer()
            }
            .frame(width: 200, height: 40)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(name)
                    Text(item)
                }
                .padding(.horizontal, 2)
            }
            .frame(width: 200, height: 50)
            HStack {
                HStack {
                    let rating = productRating
                    let intRating: Int = Int(rating)
                    let hasHalfStar: Bool = rating > Int(Float(intRating))
                    
                    ForEach(0..<5) { index in
                        if index < intRating {
                            RatingStarView(starTypeName: "star.fill")
                        } else if hasHalfStar, index == intRating {
                            RatingStarView(starTypeName: "star.leadinghalf.filled")
                        } else {
                            RatingStarView(starTypeName: "star")
                        }
                    }
                }
                .padding(.horizontal, 2)
                Spacer()
            }
            .frame(width: 200, height: 40)
            VStack {
                HStack(spacing: 5) {
                    if offerPrize != ActualPrize {
                        Text("\(offerPrize)")
                        Text("\(ActualPrize)")
                            .strikethrough(true, color: .hash)
                    } else {
                        Text("\(ActualPrize)")
                    }
                        
                    Spacer()
                }
                .padding(.horizontal, 2)
            }
            .frame(width: 200, height: 30)
            
        }
        .frame(width: 200, height: 310)
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 30)
            .stroke(Color.black.opacity(0.4)))
    }
}
struct RatingStarView: View {
    var starTypeName: String
    var body: some View {
        HStack {
            Image(systemName: starTypeName)
                .resizable()
                .frame(width: 20,height: 20)
                .foregroundColor(.yellow)
        }
    }
}
