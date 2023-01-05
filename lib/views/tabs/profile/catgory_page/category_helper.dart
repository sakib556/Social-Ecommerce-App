final categories = [
  CategoryViewModel(
    name: "Product",
    subCategories: _productList,
  ),
  CategoryViewModel(
    name: "Service",
    subCategories: _servicesList,
  ),
  CategoryViewModel(name: "Vehicle", subCategories: _skillsList),
];
List<SubCategoryViewModel> _productList = [
  SubCategoryViewModel(
    imgUrl:
        'https://images.unsplash.com/photo-1634900003938-aba5f17f3da7?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60',
    name: 'Bike',
  ),
  SubCategoryViewModel(
      imgUrl:
          'https://images.unsplash.com/photo-1593642532781-03e79bf5bec2?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=688&q=80',
      name: 'Book'),
];
List<SubCategoryViewModel> _servicesList = [
  SubCategoryViewModel(
      imgUrl:
          'https://images.unsplash.com/photo-1634900003938-aba5f17f3da7?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60',
      name: 'Services list'),
];
List<SubCategoryViewModel> _skillsList = [
  SubCategoryViewModel(
      imgUrl:
          'https://images.unsplash.com/photo-1634900003938-aba5f17f3da7?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60',
      name: 'Skill list'),
];

class CategoryViewModel {
  final String name;
  final List<SubCategoryViewModel> subCategories;
  CategoryViewModel({
    required this.name,
    required this.subCategories,
  });
}

class SubCategoryViewModel {
  String imgUrl;
  String name;
  SubCategoryViewModel({required this.imgUrl, required this.name});
}
