//
//  ViewController.swift
//  Core Data TO DO List
//
//  Created by Vaishnavi Wahgule on 19/02/25.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Table View
    let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        return table
    }()
    private var models = [ToDoListItems]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Core Data to do list"
        view.addSubview(tableView)
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter New Item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
            guard let field = alert.textFields?.first,let text = field.text,!text.isEmpty else {
                return
            }
            self.createItem(name: text)
        }))
        self.present(alert, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            let item = models[indexPath.row]

            let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            // Remove the invalid text field from the action sheet and directly present an alert
            sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
                let alert = UIAlertController(title: "Edit Item", message: "Edit your Item", preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.text = item.name
                }
                alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                    guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                        return
                    }
                    self.updateItem(item: item, newName: newName)
                    self.getAllItems()
                }))
                self.present(alert, animated: true)
            }))

            sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                self?.deleteItem(item: item)
                self?.getAllItems()
            }))

            self.present(sheet, animated: true)
    }
    func getAllItems(){
        do {
            models = try context.fetch(ToDoListItems.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            //error
        }
    }
    
    func createItem(name:String) {
        let newItem = ToDoListItems(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    
    func deleteItem(item:ToDoListItems) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            
        }
    }

    func updateItem(item:ToDoListItems, newName: String) {
        item.name = newName
        
        do {
            try context.save()
        } catch {
            
        }
    }
}

